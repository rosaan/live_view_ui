defmodule LiveViewUI.Avatar do
  @moduledoc """
  A simple avatar component for displaying user profile images with optional fallbacks.

  ## Example Usage

  Here is a basic example of setting up an avatar with an image and a fallback:

  ```elixir
  <Avatar.root>
    <Avatar.image src="/path/to/image.jpg" alt="User Avatar" />
    <Avatar.fallback>
      <span>U</span>
    </Avatar.fallback>
  </Avatar.root>
  ```

  This structure allows you to display a user's avatar image with a fallback in case the image is not available.
  """
  use Phoenix.Component
  use CVA.Component

  import LiveViewUI.Helper

  attr :class, :any, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def root(assigns) do
    ~H"""
    <div
      id={unique_id()}
      class={
        cn([
          "relative flex h-10 w-10 shrink-0 overflow-hidden rounded-full",
          @class
        ])
      }
      phx-hook="Avatar"
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  attr :class, :any, default: nil
  attr :rest, :global, include: ~w(src alt)

  def image(assigns) do
    ~H"""
    <img
      data-avatar-image
      style="display: none;"
      class={cn(["w-full h-full aspect-square", @class])}
      lazy
      {@rest}
    />
    """
  end

  attr :class, :any, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def fallback(assigns) do
    ~H"""
    <div
      data-avatar-fallback
      class={
        cn([
          "flex h-full w-full items-center justify-center rounded-full bg-muted",
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
