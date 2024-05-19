defmodule TestWeb.UI do
  @moduledoc false
  defmacro __using__(_) do
    quote do
      alias LiveViewUI.Accordion
      alias LiveViewUI.Avatar
      alias LiveViewUI.Alert
      alias LiveViewUI.Badge
      alias LiveViewUI.Button
      alias LiveViewUI.Card
      alias LiveViewUI.Error
      alias LiveViewUI.Input
      alias LiveViewUI.Label
      alias LiveViewUI.ThemeSwitcher
    end
  end
end
