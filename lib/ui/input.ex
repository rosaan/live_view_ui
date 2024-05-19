defmodule LiveViewUI.UI.Input do
  @moduledoc """
  A simple input component.
  """
  use Phoenix.Component
  use CVA.Component

  import LiveViewUI.UI.Helper

  alias LiveViewUI.UI.Error
  alias LiveViewUI.UI.Label

  attr(:id, :any, default: nil)
  attr(:name, :any)
  attr(:label, :string, default: nil)
  attr(:value, :any)

  attr(:type, :string,
    default: "text",
    values: ~w(checkbox color date datetime-local email file hidden month number password
               range radio search select tel text textarea time url week)
  )

  attr(:field, Phoenix.HTML.FormField, doc: "a form field struct retrieved from the form, for example: @form[:email]")

  attr(:errors, :list, default: [])
  attr(:checked, :boolean, doc: "the checked flag for checkbox inputs")
  attr(:prompt, :string, default: nil, doc: "the prompt for select inputs")
  attr(:options, :list, doc: "the options to pass to Phoenix.HTML.Form.options_for_select/2")
  attr(:multiple, :boolean, default: false, doc: "the multiple flag for select inputs")
  attr(:class, :any, default: nil)

  attr(:rest, :global, include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step))

  slot(:inner_block)

  def root(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(field.errors, &translate_error(&1)))
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> root()
  end

  def root(%{type: "checkbox"} = assigns) do
    assigns =
      assign_new(assigns, :checked, fn ->
        Phoenix.HTML.Form.normalize_value("checkbox", assigns[:value])
      end)

    ~H"""
    <div phx-feedback-for={@name}>
      <div class="flex">
        <input
          type="checkbox"
          id={@id}
          name={@name}
          value="true"
          checked={@checked}
          class={
            cn([
              "shrink-0 size-4 border rounded-sm accent-current focus-visible:ring-ring peer border-primary ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50",
              @class
            ])
          }
          {@rest}
        />

        <Label.root for={@id} class={cn(["text-sm ms-2.5 select-none"])}>
          <%= render_slot(@inner_block) %>
        </Label.root>
      </div>
      <Error.root :for={msg <- @errors}><%= msg %></Error.root>
    </div>
    """
  end

  def root(%{type: "select"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name}>
      <Label.root for={@id}><%= @label %></Label.root>
      <select
        id={@id}
        name={@name}
        class={
          cn([
            "py-3 px-4 pe-9 block w-full items-center justify-between mt-1.5 text-sm border rounded-md border-input bg-card ring-offset-background placeholder:text-muted focus:outline-none focus:ring-1 focus:ring-foreground focus:ring-offset-1 disabled:cursor-not-allowed disabled:opacity-50",
            "phx-no-feedback:muted phx-no-feedback:focus:border-muted",
            @errors == [] && "border-muted focus:border-muted",
            @errors != [] && "border-destructive focus:border-destructive",
            @class
          ])
        }
        multiple={@multiple}
        {@rest}
      >
        <option :if={@prompt} value=""><%= @prompt %></option>
        <%= Phoenix.HTML.Form.options_for_select(@options, @value) %>
      </select>

      <Error.root :for={msg <- @errors}><%= msg %></Error.root>
    </div>
    """
  end

  def root(%{type: "textarea"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name}>
      <Label.root for={@id}><%= @label %></Label.root>
      <textarea
        id={@id}
        name={@name}
        class={
          cn([
            "flex min-h-[80px] w-full rounded-md border border-input bg-background px-3 py-2 mt-1.5 text-sm ring-offset-background placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50",
            @errors == [] && "border-muted focus:border-muted",
            @errors != [] && "border-destructive focus:border-destructive",
            @class
          ])
        }
        {@rest}
      ><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
      <Error.root :for={msg <- @errors}><%= msg %></Error.root>
    </div>
    """
  end

  # All other inputs text, datetime-local, url, password, etc. are handled here...
  def root(assigns) do
    ~H"""
    <div phx-feedback-for={@name}>
      <Label.root for={@id}><%= @label %></Label.root>
      <input
        type={@type}
        name={@name}
        id={@id}
        value={Phoenix.HTML.Form.normalize_value(@type, @value)}
        class={
          cn([
            "border-input placeholder:text-muted focus-visible:ring-foreground block mt-1.5 w-full rounded-md border bg-card px-4 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-offset-1 disabled:cursor-not-allowed disabled:opacity-50",
            "phx-no-feedback:muted phx-no-feedback:focus:border-muted",
            @errors == [] && "border-muted focus:border-muted",
            @errors != [] && "border-destructive focus:border-destructive",
            @class
          ])
        }
        {@rest}
      />
      <Error.root :for={msg <- @errors}><%= msg %></Error.root>
    </div>
    """
  end

  def translate_errors(errors, field) when is_list(errors) do
    for {^field, {msg, opts}} <- errors, do: translate_error({msg, opts})
  end

  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(UI.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(UI.Gettext, "errors", msg, opts)
    end
  end
end
