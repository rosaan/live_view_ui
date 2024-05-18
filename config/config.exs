import Config

config :esbuild,
  version: "0.17.11",
  default: [
    args: ~w(app.ts --bundle --format=esm --sourcemap --outfile=../priv/static/live_view_ui.mjs),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_ENV" => to_string(Mix.env())}
  ]
