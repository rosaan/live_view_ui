defmodule LiveViewUI.UI.Button do
  @moduledoc """
  A simple button component for interactive actions.

  ## Example Usage

  Here is a basic example of setting up a button component:

  ```elixir
  <Button.root>
    Default Button
  </Button.root>
  ```

  You can customize the button with different variants, sizes, and HTML elements:

  ```elixir
  <Button.root variant="destructive" size="lg" as="a" class="extra-class">
    Destructive Button
  </Button.root>
  ```

  ## Attributes

  - `:variant` - The style variant of the button. Available options:
    - `:default` (default)
    - `:destructive`
    - `:outline`
    - `:outline-secondary`
    - `:secondary`
    - `:ghost`
    - `:link`
  - `:size` - The size of the button. Available options:
    - `:default` (default)
    - `:sm`
    - `:lg`
    - `:icon`
  - `:type` - The button type attribute (e.g., `"button"`, `"submit"`).
  - `:class` - Additional CSS classes to apply to the button.
  - `:as` - The HTML element to use for the button. Default is `"button"` or can be `"a"`.
  - `:rest` - Any additional attributes to apply to the button's root element, including `disabled`, `form`, `name`, and `value`.

  ## Slots

  - `:inner_block` - The content to be displayed inside the button.
  """
  use Phoenix.Component
  use CVA.Component

  import LiveViewUI.UI.Helper

  @button_variant_config [
    default: "bg-primary text-primary-foreground hover:bg-primary/90",
    destructive: "bg-destructive text-destructive-foreground hover:bg-destructive/90",
    outline: "border border-input bg-background hover:bg-accent hover:text-accent-foreground",
    "outline-secondary":
      "border border-secondary bg-background hover:bg-secondary hover:text-secondary-foreground text-secondary",
    secondary: "bg-secondary text-secondary-foreground hover:bg-secondary/80",
    ghost: "hover:bg-accent hover:text-accent-foreground",
    link: "text-primary underline-offset-4 hover:underline"
  ]

  @button_size_config [
    default: "h-10 px-4 py-2",
    sm: "h-9 rounded-md px-3",
    lg: "h-11 rounded-md px-8",
    icon: "h-10 w-10"
  ]

  @button_variant @button_variant_config |> Keyword.keys() |> Enum.map(&to_string/1)
  @button_size @button_size_config |> Keyword.keys() |> Enum.map(&to_string/1)

  def get_button_variant, do: @button_variant
  def get_button_size, do: @button_size

  def button_cva(props) do
    config = [
      variants: [
        variant: @button_variant_config,
        size: @button_size_config
      ]
    ]

    Enum.join(
      [
        "inline-flex items-center justify-center rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50",
        cva(config, props)
      ],
      " "
    )
  end

  attr(:variant, :string, default: "default", values: @button_variant)
  attr(:size, :string, default: "default", values: @button_size)
  attr(:type, :string, default: nil)
  attr(:class, :any, default: nil)
  attr(:as, :string, default: "button", values: ["button", "a"])
  attr(:rest, :global, include: ~w(disabled form name value))

  slot(:inner_block, required: true)

  def root(assigns) do
    ~H"""
    <.dynamic_tag
      name={@as}
      type={@type}
      class={
        cn([
          button_cva(variant: @variant, size: @size),
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
