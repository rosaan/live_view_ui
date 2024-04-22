# LiveViewUI

Add free, easy-to-customize components to your LiveView apps. Start building your LiveView component library today!

<p><strong style="color: red;">⚠️ WARNING:</strong> This package is still in early development. Please do not use it for production or active projects. Contributions are welcome to help make it more stable!</p>

## Installation

### Prerequisites

Make sure you have tailwindcss installed in your project.

## Step 1: Add the Dependency

Open your Phoenix project and add `live_view_ui` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:live_view_ui, "~> 0.0.1"}, # <-- Add this line
  ]
end
```

Run `mix deps.get` to fetch and install the dependencies.

## Step 2: Configure TailwindCSS

Update your `tailwind.config.js` to include the UI library's components and themes:

```javascript
module.exports = {
  content: [
    "../lib/ui/**/*.ex", // <-- Add this line
  ],
  darkMode: "class", // <-- Add this line
  theme: {
    extend: {
      colors: {
        ...require("../deps/live_view_ui/assets/tailwind.colors.json"), // <-- Add this line
      },
    },
  },
  plugins: [
    require("../deps/live_view_ui/assets/preline/plugin"), // <-- Add this line
  ],
};
```

## Step 3: Update app.css

Add the following styles to your `app.css` to integrate the library's base styles:

```css
@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 240 10% 3.9%;
    --card: 0 0% 100%;
    --card-foreground: 240 10% 3.9%;
    --popover: 0 0% 100%;
    --popover-foreground: 240 10% 3.9%;
    --primary: 240 5.9% 10%;
    --primary-foreground: 0 0% 98%;
    --secondary: 240 4.8% 95.9%;
    --secondary-foreground: 240 5.9% 10%;
    --muted: 240 4.8% 95.9%;
    --muted-foreground: 240 3.8% 46.1%;
    --accent: 240 4.8% 95.9%;
    --accent-foreground: 240 5.9% 10%;
    --destructive: 0 84.2% 60.2%;
    --destructive-foreground: 0 0% 98%;
    --border: 240 5.9% 90%;
    --input: 240 5.9% 90%;
    --ring: 240 5.9% 10%;
    --radius: 0.5rem;
  }

  .dark {
    --background: 240 10% 3.9%;
    --foreground: 0 0% 98%;
    --card: 240 10% 3.9%;
    --card-foreground: 0 0% 98%;
    --popover: 240 10% 3.9%;
    --popover-foreground: 0 0% 98%;
    --primary: 0 0% 98%;
    --primary-foreground: 240 5.9% 10%;
    --secondary: 240 3.7% 15.9%;
    --secondary-foreground: 0 0% 98%;
    --muted: 240 3.7% 15.9%;
    --muted-foreground: 240 5% 64.9%;
    --accent: 240 3.7% 15.9%;
    --accent-foreground: 0 0% 98%;
    --destructive: 0 62.8% 30.6%;
    --destructive-foreground: 0 0% 98%;
    --border: 240 3.7% 15.9%;
    --input: 240 3.7% 15.9%;
    --ring: 240 4.9% 83.9%;
  }
}

@layer base {
  * {
    @apply border-border;
  }
  body {
    @apply text-foreground bg-background;
  }
}

@keyframes slide-in {
  from {
    height: 0px;
  }
  to {
    height: var(--sprt-collapsible-content-height);
  }
}

@keyframes slide-out {
  from {
    height: var(--sprt-collapsible-content-height);
  }
  to {
    height: 0px;
  }
}

.animate-slide-down {
  animation: slide-down 200ms cubic-bezier(0.87, 0, 0.13, 1);
}

.animate-slide-up {
  animation: slide-up 200ms cubic-bezier(0.87, 0, 0.13, 1);
}

@keyframes slide-down {
  from {
    height: 0;
  }
  to {
    height: var(--panel-height);
  }
}

@keyframes slide-up {
  from {
    height: var(--panel-height);
  }
  to {
    height: 0;
  }
}

select {
  background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
  background-position: right 0.5rem center;
  background-repeat: no-repeat;
  background-size: 1.5em 1.5em;
  padding-right: 2.5rem;
  -webkit-print-color-adjust: exact;
  print-color-adjust: exact;

  /* reset */

  margin: 0;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-appearance: none;
  -moz-appearance: none;
}

::-webkit-scrollbar {
  @apply w-2 h-2;
}

::-webkit-scrollbar-track {
  @apply bg-background;
}

::-webkit-scrollbar-thumb {
  @apply rounded-full bg-zinc-700;
}

::-webkit-scrollbar-thumb:hover {
  @apply bg-zinc-800;
}

.thin-scrollbar::-webkit-scrollbar {
  @apply w-1.5 h-1.5;
}

.thin-scrollbar::-webkit-scrollbar-track {
  @apply bg-background;
}
```

Refer to the [shadcn/ui Themes](https://ui.shadcn.com/themes) to customize the colors to your liking.

## Step 4: Modify app.js

Ensure that your `app.js` is configured to utilize LiveView hooks and DOM operations from the UI library:

```javascript
import { hooks, dom } from "../../deps/live_view_ui/assets/app"; // <-- Add this line

const liveSocket = new LiveSocket("/live", Socket, {
  hooks, // <-- Add this line
  dom, // <-- Add this line
});
```

## Step 5: Copy the UI Components

1. **Copy the UI Components**: To use the UI components provided by the library, you need to copy them into your project directory. Run the following command in your terminal:

   ```bash
   cp -R ./deps/live_view_ui/lib/ui ./lib
   ```

2. Change the Gettext module in `./lib/ui/input.ex` to match your project's Gettext module.

## Step 6: For dark mode support

If you want to support dark mode, you need to add the following code to your `root.html.heex`:

```html
<!DOCTYPE html>
<html lang="en" class="[scrollbar-gutter:stable] h-full">
  <!-- Make sure to add the bg-background class and other utility classes. If there is other bg- class, you can remove it -->
  <body
    class="h-full relative antialiased bg-background [scrollbar-gutter:stable]"
  >
    <-- make sure to add the bg-background class <%= @inner_content %>
    <!-- Add this script -->
    <script>
      const e =
        localStorage.getItem("theme") ||
        (window.matchMedia("(prefers-color-scheme: dark)").matches
          ? "dark"
          : "light");
      document.documentElement.classList.toggle("dark", "dark" === e);
    </script>
  </body>
</html>
```

# Acknowledgements

This project is inspired by [shadcn/ui](https://ui.shadcn.com/). Thank you for the amazing work you do!

Thank you to [preline](https://preline.co/) for their amazing work on the plugins and components that make this library possible.
