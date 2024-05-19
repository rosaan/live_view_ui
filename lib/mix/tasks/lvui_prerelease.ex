defmodule Mix.Tasks.Lvui.Prerelease do
  @shortdoc "Sets up LiveViewUI in your Phoenix project"
  @shortdoc "Copies files from lib/ui to priv/templates/ui and replaces LiveViewUI with <%= @module_name %>"

  @moduledoc false
  use Mix.Task

  def run(_args) do
    source = "lib/ui"
    destination = "priv/templates/ui"

    File.rm_rf!(destination)
    File.mkdir_p!(destination)

    source
    |> File.ls!()
    |> Enum.each(&process_file(&1, source, destination))
  end

  defp process_file(file, source, destination) do
    source_path = Path.join(source, file)
    destination_path = Path.join(destination, file)

    content = File.read!(source_path)
    updated_content = String.replace(content, "LiveViewUI", "<%= @module_name %>.UI")

    File.write!(destination_path, updated_content)
    Mix.shell().info("Processed #{file}")
  end
end
