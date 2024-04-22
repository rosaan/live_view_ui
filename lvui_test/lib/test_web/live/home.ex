defmodule TestWeb.HomeLive do
  use TestWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="space-y-4">
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
                  Accordion Item 1
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
        </Card.content>
      </Card.root>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
