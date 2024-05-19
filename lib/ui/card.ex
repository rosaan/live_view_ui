defmodule LiveViewUI.Card do
  @moduledoc """
  A simple card component.
  """
  use Phoenix.Component

  import LiveViewUI.Helper

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def root(assigns) do
    ~H"""
    <div class={cn(["border rounded-lg shadow-sm bg-card text-card-foreground", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def header(assigns) do
    ~H"""
    <div class={cn(["flex flex-col space-y-1.5 p-6", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def title(assigns) do
    ~H"""
    <h3 class={cn(["text-2xl font-semibold leading-none tracking-tight", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </h3>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def description(assigns) do
    ~H"""
    <p class={cn(["text-sm text-muted-foreground", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  attr(:no_header, :boolean, default: false)
  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def content(assigns) do
    ~H"""
    <div class={cn(["p-6", @class, !@no_header && "pt-0"])} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def footer(assigns) do
    ~H"""
    <div class={cn(["flex items-center p-6 pt-0", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
