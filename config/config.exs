# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pxblog,
  ecto_repos: [Pxblog.Repo]

# Configures the endpoint
config :pxblog, Pxblog.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5Y2kFYMDCQDZlokrNRjW6dR815EKv7lHhEb89gWNRurntAsbQDa77ARgds7zjIBi",
  render_errors: [view: Pxblog.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pxblog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
