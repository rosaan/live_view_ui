import Config

config :esbuild,
  version: "0.21.3",
  default: [
    args:
      ~w(app.ts --bundle --format=esm --sourcemap --minify --legal-comments=none --outfile=../priv/static/live_view_ui.mjs),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_ENV" => "production"}
  ]
