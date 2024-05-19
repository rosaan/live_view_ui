defmodule LiveViewUI.Error do
  @moduledoc """
  A simple error component.
  """
  use Phoenix.Component

  slot(:inner_block, required: true)

  def root(assigns) do
    ~H"""
    <p class="flex gap-3 mt-3 text-sm leading-6 text-rose-600 phx-no-feedback:hidden">
      <Lucide.alert_circle class="mt-0.5 h-5 w-5 flex-none" />
      <%= render_slot(@inner_block) %>
    </p>
    """
  end
end
