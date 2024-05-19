defmodule LiveViewUI.Label do
  @moduledoc """
  A simple label component.
  """
  use Phoenix.Component

  import LiveViewUI.Helper

  attr(:for, :string, required: true)
  attr(:class, :any, default: nil)
  attr(:rest, :global, include: ~w(for))
  slot(:inner_block, required: true)

  def root(assigns) do
    ~H"""
    <label
      for={@for}
      class={
        cn([
          "text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70",
          @class
        ])
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </label>
    """
  end
end
