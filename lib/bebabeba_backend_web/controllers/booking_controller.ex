defmodule BebabebaBackendWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :bebabeba_backend

  socket "/socket", BebabebaBackendWeb.UserSocket

  plug Plug.Static,
    at: "/",
    from: :bebabeba_backend,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Enable code reloading in development
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_bebabeba_backend_key",
    signing_salt: "randomsalt"

  plug BebabebaBackendWeb.Router
end
