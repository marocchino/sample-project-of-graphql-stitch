# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :image,
  ecto_repos: [Image.Repo]

# Configures the endpoint
config :image, ImageWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MEAhIZFZ+/4ZvEXD24fFtyQ+KPNAg8HIPvbO9/yeYKEZ8sO/B5BhBo6baXfuKMBT",
  render_errors: [view: ImageWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Image.PubSub,
  live_view: [signing_salt: "thoRje1o"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
