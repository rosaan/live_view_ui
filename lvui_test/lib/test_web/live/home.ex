defmodule TestWeb.HomeLive do
  use TestWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <Button.root>
        <.link navigate={~p"/empty"}>Navigate to Empty Page</.link>
      </Button.root>
      <Card.root>
        <Card.header>
          <Card.title>
            Button
          </Card.title>
        </Card.header>
        <Card.content>
          <Button.root>
            Click me
          </Button.root>
        </Card.content>
      </Card.root>

      <Card.root>
        <Card.header>
          <Card.title>
            Theme Switcher
          </Card.title>
        </Card.header>
        <Card.content>
          <ThemeSwitcher.root />
        </Card.content>
      </Card.root>

      <Card.root>
        <Card.header>
          <Card.title>
            Accordion
          </Card.title>
        </Card.header>
        <Card.content>
          <Accordion.root>
            <Accordion.item id="1">
              <Accordion.trigger>
                Accordion Item 1 <%= @accordion_title %>
              </Accordion.trigger>
              <Accordion.content>
                <p>
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nec purus nec nunc.
                </p>
              </Accordion.content>
            </Accordion.item>
            <Accordion.item id="2">
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
          <Card.footer>
            <Button.root phx-click="update-title">Update Title</Button.root>
          </Card.footer>
        </Card.content>
      </Card.root>

      <Card.root>
        <Card.header>
          <Card.title>
            Alert
          </Card.title>
        </Card.header>
        <Card.content>
          <Alert.root>
            <Lucide.terminal class="size-4" />
            <Alert.title>Heads up!</Alert.title>
            <Alert.description>
              You can add components to your app using the cli.
            </Alert.description>
          </Alert.root>
        </Card.content>
      </Card.root>

      <Card.root>
        <Card.header>
          <Card.title>
            Avatar
          </Card.title>
        </Card.header>
        <Card.content>
          <Avatar.root>
            <Avatar.image src={@image} />
            <Avatar.fallback>
              AV
            </Avatar.fallback>
          </Avatar.root>
          <Card.footer>
            <Button.root phx-click="inject-image">Update Image</Button.root>
          </Card.footer>
        </Card.content>
      </Card.root>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(accordion_title: "Default", image: "invalid_image")}
  end

  def handle_event("update-title", _payload, socket) do
    random_names = ["John", "Doe", "Jane", "Smith"]
    {:noreply, socket |> assign(accordion_title: Enum.random(random_names))}
  end


  def handle_event("inject-image", _payload, socket) do
    {:noreply, socket |> assign(image: "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=3270&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")}
  end
end
