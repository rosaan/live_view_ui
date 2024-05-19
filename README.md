# LiveViewUI

Add free, easy-to-customize components to your LiveView apps. Start building your LiveView component library today!

<p><strong style="color: red;">⚠️ WARNING:</strong> This package is still in early development. Please do not use it for production or active projects. Contributions are welcome to help make it more stable!</p>

## Installation

### Prerequisites

Make sure you have tailwindcss installed in your phoenix app.

## Step 1: Add the Dependency

Open your Phoenix project and add `live_view_ui` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:live_view_ui, "~> 0.0.7"}, # <-- Add this line
  ]
end
```

Run `mix deps.get` to fetch and install the dependencies.

## Step 2: Setup

Run the following mix command to copy and install the necessary assets:

```bash
mix live_view_ui.setup
```

# Usage

Refer to the [shadcn/ui Themes](https://ui.shadcn.com/themes) to customize the colors to your liking.

# Acknowledgements

This project is inspired by [shadcn/ui](https://ui.shadcn.com/). Thank you for the amazing work you do!

Thank you to [preline](https://preline.co/) for their amazing work on the plugins and components that make this library possible.
