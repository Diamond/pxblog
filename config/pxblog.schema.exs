[
  mappings: [
    "logger.console.format": [
      doc: "Provide documentation for logger.console.format here.",
      to: "logger.console.format",
      datatype: :binary,
      default: """
      $time $metadata[$level] $message
      """
    ],
    "logger.console.metadata": [
      doc: "Provide documentation for logger.console.metadata here.",
      to: "logger.console.metadata",
      datatype: [
        list: :atom
      ],
      default: [
        :request_id
      ]
    ],
    "logger.level": [
      doc: "Provide documentation for logger.level here.",
      to: "logger.level",
      datatype: :atom,
      default: :info
    ],
    "pxblog.Elixir.Pxblog.Endpoint.root": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Endpoint.root here.",
      to: "pxblog.Elixir.Pxblog.Endpoint.root",
      datatype: :binary,
      default: "/Users/brichey/Documents/dev/phoenix/pxblog"
    ],
    "pxblog.Elixir.Pxblog.Endpoint.render_errors.accepts": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Endpoint.render_errors.accepts here.",
      to: "pxblog.Elixir.Pxblog.Endpoint.render_errors.accepts",
      datatype: [
        list: :binary
      ],
      default: [
        "html",
        "json"
      ]
    ],
    "pxblog.Elixir.Pxblog.Endpoint.pubsub.name": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Endpoint.pubsub.name here.",
      to: "pxblog.Elixir.Pxblog.Endpoint.pubsub.name",
      datatype: :atom,
      default: Pxblog.PubSub
    ],
    "pxblog.Elixir.Pxblog.Endpoint.pubsub.adapter": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Endpoint.pubsub.adapter here.",
      to: "pxblog.Elixir.Pxblog.Endpoint.pubsub.adapter",
      datatype: :atom,
      default: Phoenix.PubSub.PG2
    ],
    "pxblog.Elixir.Pxblog.Endpoint.http.port": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Endpoint.http.port here.",
      to: "pxblog.Elixir.Pxblog.Endpoint.http.port",
      datatype: :binary,
      default: nil
    ],
    "pxblog.Elixir.Pxblog.Endpoint.url.host": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Endpoint.url.host here.",
      to: "pxblog.Elixir.Pxblog.Endpoint.url.host",
      datatype: :binary,
      default: "example.com"
    ],
    "pxblog.Elixir.Pxblog.Endpoint.url.port": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Endpoint.url.port here.",
      to: "pxblog.Elixir.Pxblog.Endpoint.url.port",
      datatype: :integer,
      default: 80
    ],
    "pxblog.Elixir.Pxblog.Endpoint.cache_static_manifest": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Endpoint.cache_static_manifest here.",
      to: "pxblog.Elixir.Pxblog.Endpoint.cache_static_manifest",
      datatype: :binary,
      default: "priv/static/manifest.json"
    ],
    "pxblog.Elixir.Pxblog.Endpoint.server": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Endpoint.server here.",
      to: "pxblog.Elixir.Pxblog.Endpoint.server",
      datatype: :atom,
      default: true
    ],
    "pxblog.Elixir.Pxblog.Endpoint.secret_key_base": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Endpoint.secret_key_base here.",
      to: "pxblog.Elixir.Pxblog.Endpoint.secret_key_base",
      datatype: :binary,
      default: "fmEw9VvdugAYE+2kNnWz5OgB99A0PW/bmVwlC9wm9To8FBfKP2rKiaaIPfgf6adq"
    ],
    "pxblog.Elixir.Pxblog.Repo.adapter": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Repo.adapter here.",
      to: "pxblog.Elixir.Pxblog.Repo.adapter",
      datatype: :atom,
      default: Ecto.Adapters.Postgres
    ],
    "pxblog.Elixir.Pxblog.Repo.username": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Repo.username here.",
      to: "pxblog.Elixir.Pxblog.Repo.username",
      datatype: :binary,
      default: "postgres"
    ],
    "pxblog.Elixir.Pxblog.Repo.password": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Repo.password here.",
      to: "pxblog.Elixir.Pxblog.Repo.password",
      datatype: :binary,
      default: "postgres"
    ],
    "pxblog.Elixir.Pxblog.Repo.database": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Repo.database here.",
      to: "pxblog.Elixir.Pxblog.Repo.database",
      datatype: :binary,
      default: "pxblog_prod"
    ],
    "pxblog.Elixir.Pxblog.Repo.pool_size": [
      doc: "Provide documentation for pxblog.Elixir.Pxblog.Repo.pool_size here.",
      to: "pxblog.Elixir.Pxblog.Repo.pool_size",
      datatype: :integer,
      default: 20
    ],
    "comeonin.bcrypt_log_rounds": [
      doc: "Provide documentation for comeonin.bcrypt_log_rounds here.",
      to: "comeonin.bcrypt_log_rounds",
      datatype: :integer,
      default: 14
    ],
    "phoenix.generators.migration": [
      doc: "Provide documentation for phoenix.generators.migration here.",
      to: "phoenix.generators.migration",
      datatype: :atom,
      default: true
    ],
    "phoenix.generators.binary_id": [
      doc: "Provide documentation for phoenix.generators.binary_id here.",
      to: "phoenix.generators.binary_id",
      datatype: :atom,
      default: false
    ]
  ],
  translations: [
  ]
]