defmodule LiveViewUI.UI.ThemeSwitcher do
  @moduledoc """
  A component that provides a way to switch between dark mode and light mode.

  ## Example Usage

  Here is a basic example of setting up the theme switcher component:

  ```elixir
  <ThemeSwitcher.root />
  ```

  Place this component in your layout or any other part of your application where you want to provide a way to switch between themes.
  """

  use Phoenix.Component

  alias LiveViewUI.UI.Button

  def root(assigns) do
    ~H"""
    <Button.root id="theme-switcher" variant="secondary" size="sm" phx-hook="ThemeSwitcher">
      <Lucide.sun class="block size-4 dark:hidden" />
      <Lucide.moon class="hidden size-4 dark:block " />
    </Button.root>
    """
  end
end
