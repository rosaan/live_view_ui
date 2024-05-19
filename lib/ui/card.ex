defmodule LiveViewUI.Card do
  @moduledoc """
  A simple card component for displaying content within a bordered and rounded container.

  ## Example Usage

  Here is a basic example of setting up a card component:

  ```elixir
  <Card.root>
    <Card.header>
      <Card.title>
        Card Title
      </Card.title>
      <Card.description>
        This is a description of the card.
      </Card.description>
    </Card.header>
    <Card.content>
      <p>Card content goes here.</p>
    </Card.content>
    <Card.footer>
      <Button.root>Footer Button</Button.root>
    </Card.footer>
  </Card.root>
  ```

  ## Components

  - `LiveViewUI.Card.root` - The main container for the card.
  - `LiveViewUI.Card.header` - The header section of the card.
  - `LiveViewUI.Card.title` - The title element within the card header.
  - `LiveViewUI.Card.description` - The description element within the card header.
  - `LiveViewUI.Card.content` - The content section of the card.
  - `LiveViewUI.Card.footer` - The footer section of the card.

  ## Attributes

  ### `LiveViewUI.Card.root`
  - `:class` - Additional CSS classes to apply to the card.
  - `:rest` - Any additional attributes to apply to the card's root element.

  ### `LiveViewUI.Card.header`
  - `:class` - Additional CSS classes to apply to the header.
  - `:rest` - Any additional attributes to apply to the header's root element.

  ### `LiveViewUI.Card.title`
  - `:class` - Additional CSS classes to apply to the title.
  - `:rest` - Any additional attributes to apply to the title's root element.

  ### `LiveViewUI.Card.description`
  - `:class` - Additional CSS classes to apply to the description.
  - `:rest` - Any additional attributes to apply to the description's root element.

  ### `LiveViewUI.Card.content`
  - `:no_header` - A boolean to specify if the content should have padding at the top. Default is `false`.
  - `:class` - Additional CSS classes to apply to the content.
  - `:rest` - Any additional attributes to apply to the content's root element.

  ### `LiveViewUI.Card.footer`
  - `:class` - Additional CSS classes to apply to the footer.
  - `:rest` - Any additional attributes to apply to the footer's root element.

  ## Slots

  - `:inner_block` - The content to be displayed inside each section of the card.
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
