defmodule LiveViewUI.UI.Alert do
  @moduledoc """
  A simple alert component for displaying important messages.

  ## Example Usage

  Here is a basic example of setting up an alert with a title and description:

  ```elixir
  <Alert.root variant={:warning}>
    <Lucide.terminal class="size-4" />
    <Alert.title>Heads up!</Alert.title>
    <Alert.description>
      You can add components to your app using the CLI.
    </Alert.description>
  </Alert.root>
  ```

  This structure allows you to create styled alert messages with customizable content.
  """
  use Phoenix.Component
  use CVA.Component

  import LiveViewUI.UI.Helper

  variant(
    :variant,
    [
      default: "bg-background text-foreground",
      warning: ~s"bg-amber-50 dark:bg-amber-950 text-amber-900 dark:text-amber-100
        border-amber-300 dark:border-amber-700 [&>svg]:text-amber-900
        [&>svg]:stroke-amber-900 dark:[&>svg]:stroke-amber-100 dark:[&>svg]:text-amber-100",
      destructive: ~s"bg-background border-destructive/50 text-destructive dark:border-destructive
        [&>svg]:text-destructive [&>svg]:stroke-destructive"
    ],
    default: :default
  )

  attr(:class, :any, default: nil)
  attr(:rest, :global)
  slot(:inner_block, required: true)

  def root(assigns) do
    ~H"""
    <div
      role="alert"
      class={
        cn([
          ~s"relative w-full rounded-lg border p-4 [&>svg~*]:pl-7 [&>svg+div]:translate-y-[-1px]
          [&>svg]:absolute [&>svg]:left-4 [&>svg]:top-4 [&>svg]:text-foreground",
          @cva_class,
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

  def title(assigns) do
    ~H"""
    <div
      class={
        cn([
          "mb-1 font-medium leading-none tracking-tight",
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

  def description(assigns) do
    ~H"""
    <div
      class={
        cn([
          "text-sm [&_p]:leading-relaxed",
          @class
        ])
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
