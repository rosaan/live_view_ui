defmodule Mix.Tasks.LiveViewUi.Setup do
  @shortdoc "Sets up LiveViewUI in your Phoenix project"
  @moduledoc false
  use Mix.Task

  def run(_) do
    if File.exists?(".git") do
      {result, _exit_code} = System.cmd("git", ["diff", "--exit-code"])

      if result != "" do
        Mix.shell().error(
          "There are uncommitted changes in your git repository. Please commit or stash them before running this task."
        )

        System.halt(1)
      end
    end

    Mix.shell().info("Welcome to the LiveViewUI setup!")

    inject_tailwind_config()
    update_app_css()
    modify_app_js()
    copy_ui_components()
    add_dark_mode_support()

    Mix.shell().info("LiveViewUI setup complete!")

    # Run mix format
    Mix.Task.run("format")
  end

  defp inject_tailwind_config do
    # Step 1: Copy the tailwind.colors.json file
    copy_tailwind_colors()

    # Step 2: Inject the Tailwind configuration
    file = "assets/tailwind.config.js"

    patterns = [
      {~r/content:\s*\[/, "\"../lib/ui/**/*.ex\","},
      {~r/module.exports\s*=\s*\{/, "darkMode: \"class\","},
      {~r/plugins:\s*\[/, "require(\"live_view_ui/tailwind\"),"}
    ]

    inject_patterns(file, patterns)
    inject_colors(file)

    # Step 3: Inject the config into config.exs
    inject_config()
  end

  defp update_app_css do
    file = "assets/css/app.css"
    styles_dir = Application.app_dir(:live_view_ui, "priv/styles.css")
    styles = File.read!(styles_dir)
    inject_line(file, ~r/\z/, styles)
  end

  defp modify_app_js do
    file = "assets/js/app.js"

    js_lines = [
      {~r/^/, "import { hooks, dom } from \"live_view_ui\";\n"},
      {~r/let\s+liveSocket\s*=\s*new\s+LiveSocket\(".*",\s*Socket,\s*\{/, "  hooks,"},
      {~r/let\s+liveSocket\s*=\s*new\s+LiveSocket\(".*",\s*Socket,\s*\{/, "  dom,"}
    ]

    inject_patterns(file, js_lines)
  end

  defp copy_ui_components do
    otp_app = Mix.Phoenix.context_app()
    module_name = otp_app |> Atom.to_string() |> Macro.camelize()
    ui_dir = Application.app_dir(:live_view_ui, "priv/templates/ui")
    current_ui_dir = Path.join(["lib", "ui"])

    Mix.shell().info("Copying UI components...")

    if File.exists?(current_ui_dir) do
      Mix.shell().info("UI components already exist in lib/ui. Skipping.")
      File.mkdir_p!(current_ui_dir)
    end

    Enum.each(File.ls!(ui_dir), fn file ->
      if File.exists?(Path.join([current_ui_dir, file])) do
        Mix.shell().info("File #{file} already exists in lib/ui. Skipping.")
      else
        file_path = Path.join([ui_dir, file])
        file_content = File.read!(file_path)
        gettext_module = "#{module_name}Web.Gettext"

        new_content =
          file_content
          |> String.replace("<%= @module_name %>", module_name)
          |> String.replace("<%= @gettext %>", gettext_module)

        new_file_path = Path.join([current_ui_dir, file])
        File.write!(new_file_path, new_content)
      end
    end)

    Mix.shell().info("UI components copied.")
  end

  defp add_dark_mode_support do
    otp_app = Mix.Phoenix.context_app()
    file = "lib/#{otp_app}_web/components/layouts/root.html.heex"

    script = """
    <script>
      const e = localStorage.getItem("theme") ||
                (window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light");
      document.documentElement.classList.toggle("dark", "dark" === e);
    </script>
    """

    inject_line(file, ~r/<\/body>/, script, :before)

    contents = File.read!(file)
    updated_contents = Regex.replace(~r/\bbg-\S*/, contents, "bg-background")
    File.write!(file, updated_contents)
  end

  defp copy_tailwind_colors do
    source = Application.app_dir(:live_view_ui, "priv/templates/tailwind.colors.json")
    destination = "assets/tailwind.colors.json"

    File.cp!(source, destination)
    Mix.shell().info("Copied tailwind.colors.json")
  end

  defp inject_colors(file) do
    if File.exists?(file) do
      contents = File.read!(file)

      new_contents =
        contents
        |> ensure_pattern(~r/theme:\s*\{/, "  theme: {},")
        |> ensure_pattern(~r/extend:\s*\{/, "    extend: {},")
        |> ensure_colors()

      File.write!(file, new_contents)
      Mix.shell().info("TailwindCSS colors configuration updated.")
    else
      Mix.shell().info("#{file} not found. Skipping colors injection.")
    end
  end

  defp ensure_pattern(contents, pattern, line) do
    if Regex.match?(pattern, contents) do
      contents
    else
      Regex.replace(~r/(module.exports\s*=\s*\{)([^}]*)\}/, contents, "\\1\n#{line}\\2}")
    end
  end

  defp ensure_colors(contents) do
    color_pattern = ~r/require\("\.\/tailwind\.colors\.json"\)/

    if Regex.match?(color_pattern, contents) do
      contents
    else
      if Regex.match?(~r/colors:\s*\{/, contents) do
        Regex.replace(
          ~r/(colors:\s*\{)([^}]*)\}/,
          contents,
          "\\1\n        ...require(\"./tailwind.colors.json\"),\\2}"
        )
      else
        Regex.replace(
          ~r/(extend:\s*\{)([^}]*)\}/,
          contents,
          "\\1\n      colors: {\n        ...require(\"./tailwind.colors.json\")\n      },\\2}"
        )
      end
    end
  end

  defp inject_config do
    file = "config/config.exs"
    pattern = ~r/import Config/

    line = """
    \nconfig :tails, colors_file: Path.join(File.cwd!(), "assets/tailwind.colors.json")
    """

    inject_line(file, pattern, line, :after)
  end

  defp inject_patterns(file, patterns) do
    Enum.each(patterns, fn {pattern, line} ->
      inject_line(file, pattern, line)
    end)
  end

  defp inject_line(file, pattern, line, position \\ :after) do
    if File.exists?(file) do
      contents = File.read!(file)

      if Regex.match?(pattern, contents) do
        if String.contains?(contents, line) do
          Mix.shell().info("Code content already present in #{file}. Skipping.")
        else
          new_contents =
            case position do
              :after -> Regex.replace(pattern, contents, "\\0\n#{line}")
              :before -> Regex.replace(pattern, contents, "#{line}\n\\0")
            end

          File.write!(file, new_contents)
        end
      else
        Mix.shell().info("Pattern not found in #{file}.")

        message = """
        Unable to automatically inject the code.
        Please manually add the following line to the appropriate section in #{file}:
        #{line}
        """

        Mix.shell().info(box_around(message))
      end
    else
      Mix.shell().info("#{file} not found. Skipping.")
    end
  end

  defp box_around(message) do
    lines = String.split(message, "\n")
    padded_lines = Enum.map(lines, &("  " <> &1))
    max_length_with_padding = padded_lines |> Enum.max_by(&String.length/1) |> String.length()
    border = String.duplicate("─", max_length_with_padding + 2)

    top_border = "┌#{border}┐"
    bottom_border = "└#{border}┘"
    middle = Enum.map_join(padded_lines, "\n", fn line -> "│ #{String.pad_trailing(line, max_length_with_padding)} │" end)

    """
    #{top_border}
    #{middle}
    #{bottom_border}
    """
  end
end
