defmodule LiveViewUI.AlertDialog do
  @moduledoc """
  A simple alert dialog component.
  """
  use Phoenix.Component

  import LiveViewUI.Helper

  @doc """
  Renders an alert dialog

  ## Examples
    <.dialog :let={
      %{
        root: root,
        trigger: trigger,
        backdrop: backdrop,
        content: content,
        title: title,
        description: description,
        actions: actions
      }
    }>
      <.trigger trigger={trigger}>Open</.trigger>
      <.content root={root} backdrop={backdrop} content={content}>
        <.header>
          <.title title={title}>Are you absolutely sure?</.title>
          <.description description={description}>
            This action cannot be undone. This will permanently delete your account
            and remove your data from our servers.
          </.description>
        </.header>
        <.footer>
          <.cancel actions={actions}>Cancel</.cancel>
          <.action>Continue</.action>
        </.footer>
      </.content>
    </.dialog>
  """

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def root(assigns) do
    ~H"""
    <div class={cn([@class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:trigger, :string, required: true)
  attr(:variant, :string, default: "default", values: LiveViewUI.Button.get_button_variant())
  attr(:size, :string, default: "default", values: LiveViewUI.Button.get_button_size())
  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def trigger(assigns) do
    ~H"""
    <LiveViewUI.Button.root
      data-hs-overlay={"##{@trigger}"}
      variant={@variant}
      size={@size}
      class={cn([@class])}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </LiveViewUI.Button.root>
    """
  end

  attr(:id, :string, required: true)
  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def portal(assigns) do
    ~H"""
    <.focus_wrap
      id={@id || Map.get(assigns.rest, "id", "focus-wrap")}
      class={
        cn([
          "relative z-50 group",
          "hs-overlay hs-overlay-open:opacity-100 hs-overlay-open:duration-500 hidden size-full fixed",
          "top-0 start-0 z-[80] opacity-0 overflow-x-hidden transition-all overflow-y-auto pointer-events-none",
          @class
        ])
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </.focus_wrap>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)

  def overlay(assigns) do
    ~H"""
    <div
      class={
        cn([
          "fixed inset-0 z-50 bg-black/80 lv-open:animate-in lv-closed:animate-out",
          "lv-closed:fade-out-0 lv-open:fade-in-0",
          @class
        ])
      }
      {@rest}
    />
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def content(assigns) do
    ~H"""
    <div
      class={
        cn([
          "fixed left-[50%] top-[50%] z-50 grid w-full max-w-lg translate-x-[-50%] translate-y-[-50%] gap-4 border p-6 bg-background",
          "shadow-lg duration-200 lv-open:animate-in lv-closed:animate-out lv-closed:fade-out-0",
          "lv-open:fade-in-0 lv-closed:zoom-out-95 lv-open:zoom-in-95",
          "lv-closed:slide-out-to-left-1/2 lv-closed:slide-out-to-top-[48%] lv-open:slide-in-from-left-1/2",
          "lv-open:slide-in-from-top-[48%] sm:rounded-lg",
          @class
        ])
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def header(assigns) do
    ~H"""
    <div class={cn(["flex flex-col space-y-2 text-center sm:text-left", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def footer(assigns) do
    ~H"""
    <div class={cn(["flex flex-col-reverse sm:flex-row sm:justify-end sm:space-x-2", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def title(assigns) do
    ~H"""
    <div class={cn(["text-lg font-semibold", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def description(assigns) do
    ~H"""
    <div class={cn(["text-sm text-muted-foreground", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr(:variant, :string, default: "default", values: LiveViewUI.Button.get_button_variant())
  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def action(assigns) do
    ~H"""
    <LiveViewUI.Button.root variant={@variant} class={cn([@class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </LiveViewUI.Button.root>
    """
  end

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def cancel(assigns) do
    ~H"""
    <LiveViewUI.Button.root variant="outline" class={cn(["mt-2 sm:mt-0", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </LiveViewUI.Button.root>
    """
  end
end
