import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :test, TestWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "+lOL8dk7i5GJf/AHTGq2cwgruxCPeLlCQ0++iRCUBEAsIsNc6OvbiS5u2Ja7iWRA",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
