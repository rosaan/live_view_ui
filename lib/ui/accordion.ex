defmodule LiveViewUI.UI.Accordion do
  @moduledoc """
  A simple accordion component for dynamically displaying collapsible content panels.

  ## Example Usage

  Here is a basic example of setting up an accordion with two items:

  ```elixir
  <Accordion.root>
    <Accordion.item id="item-1">
      <Accordion.trigger>
        Accordion Item 1
      </Accordion.trigger>
      <Accordion.content>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec purus nec nunc.
        </p>
      </Accordion.content>
    </Accordion.item>
    <Accordion.item id="item-2">
      <Accordion.trigger>
        Accordion Item 2
      </Accordion.trigger>
      <Accordion.content>
        <p>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec purus nec nunc.
        </p>
      </Accordion.content>
    </Accordion.item>
  </Accordion.root>
  ```

  This structure allows you to toggle visibility of each content panel, providing a streamlined user experience.
  """
  use Phoenix.Component

  import LiveViewUI.UI.Helper

  attr :multiple, :boolean, default: false
  attr :class, :any, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def root(assigns) do
    ~H"""
    <div class={cn(["hs-accordion-group", @class])} data-hs-accordion-always-open={@multiple} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :id, :string, required: true
  attr :active, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :class, :any, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def item(assigns) do
    ~H"""
    <div
      id={"accordion-item-#{@id}"}
      phx-hook="Accordion"
      class={cn(["hs-accordion", if(@active, do: "active", else: ""), @class])}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :class, :any, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def trigger(assigns) do
    ~H"""
    <div class={
      cn([
        "hs-accordion-toggle",
        "flex"
      ])
    }>
      <button
        type="button"
        class={
          cn([
            "flex flex-1 items-center justify-between py-4 font-medium transition-all hover:underline",
            @class
          ])
        }
        {@rest}
      >
        <h3><%= render_slot(@inner_block) %></h3>
        <Lucide.chevron_down class="w-4 h-4 transition-transform duration-200 shrink-0 hs-accordion-active:rotate-180" />
      </button>
    </div>
    """
  end

  attr :active, :boolean, default: false
  attr :class, :any, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def content(assigns) do
    ~H"""
    <section
      class={
        cn([
          "hs-accordion-content",
          "w-full overflow-hidden transition-[height] duration-300 text-sm",
          if(!@active, do: "hidden", else: ""),
          @class
        ])
      }
      {@rest}
    >
      <div class="overflow-hidden">
        <div class="pt-0 pb-4">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </section>
    """
  end
end
