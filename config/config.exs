# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :navigator,
  ecto_repos: [Navigator.Repo]

# Configures the endpoint
config :navigator, NavigatorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4U4ZhLTxDdY2k8HRuZLHZRg70kyh7Hk8Wt2akyaTEj7gLnjRNO3iDmyY/tH9NVKb",
  render_errors: [view: NavigatorWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Navigator.PubSub,
  live_view: [signing_salt: "njQMA4yL"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
