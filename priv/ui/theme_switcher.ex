defmodule ThemeSwitcher do
  @moduledoc """
  A module that provides a way to switch between dark mode and light mode.
  """

  use Phoenix.Component

  def root(assigns) do
    ~H"""
    <Button.root id="theme-switcher" variant="secondary" size="sm" phx-hook="ThemeSwitcher">
      <Lucide.sun class="block size-4 dark:hidden" />
      <Lucide.moon class="hidden size-4 dark:block " />
    </Button.root>
    """
  end
end
