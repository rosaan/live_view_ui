defmodule TestWeb.EmptyLive do
  use TestWeb, :live_view

  def render(assigns) do
    ~H"""
    <div>
      <Button.root>
        <.link navigate={~p"/"}>Go back home</.link>
      </Button.root>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
