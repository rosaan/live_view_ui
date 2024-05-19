defmodule LiveViewUI.Badge do
  @moduledoc """
  A simple badge component.
  """
  use Phoenix.Component
  use CVA.Component

  import LiveViewUI.Helper

  variant(
    :variant,
    [
      default: "border-transparent bg-primary text-primary-foreground hover:bg-primary/80",
      secondary: "border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80",
      destructive: "border-transparent bg-destructive text-destructive-foreground hover:bg-destructive/80",
      outline: "text-foreground"
    ],
    default: :default
  )

  attr(:as, :string, default: "span", values: ["span", "div"])
  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def root(assigns) do
    ~H"""
    <.dynamic_tag
      name={@as}
      class={
        cn([
          "inline-flex items-center rounded-full border px-2.5 py-0.5 text-xs font-semibold transition-colors focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2",
          @cva_class,
          @class
        ])
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end
end
