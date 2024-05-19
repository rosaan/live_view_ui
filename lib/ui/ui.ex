defmodule LiveViewUI.UI do
  @moduledoc false
  defmacro __using__(_) do
    quote do
      alias LiveViewUI.UI.Accordion
      alias LiveViewUI.UI.Alert
      alias LiveViewUI.UI.AlertDialog
      alias LiveViewUI.UI.Badge
      alias LiveViewUI.UI.Button
      alias LiveViewUI.UI.Card
      alias LiveViewUI.UI.Error
      alias LiveViewUI.UI.Input
      alias LiveViewUI.UI.Label
      alias LiveViewUI.UI.ThemeSwitcher
    end
  end
end
