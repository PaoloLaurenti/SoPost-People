# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sopost_people,
  ecto_repos: [SopostPeople.Repo]

# Configures the endpoint
config :sopost_people, SopostPeople.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v+t0/QsfLqEFgzI0cGUEO3bNGaRt5v+81CYk55ru9XhMq0eIah+m3RDCK77z4Ppd",
  render_errors: [view: SopostPeople.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SopostPeople.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
