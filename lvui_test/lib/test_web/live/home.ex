defmodule TestWeb.HomeLive do
  use TestWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <Button.root>
          Click me
      </Button.root>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
