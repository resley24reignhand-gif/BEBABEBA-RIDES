defmodule BEBABEBA_RIDESWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :bebabe_ba_rides

  socket "/socket", BEBABEBA_RIDESWeb.UserSocket

  plug Plug.Static,
    at: "/",
    from: :bebabe_ba_rides,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  
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
    key: "_bebabe_ba_rides_key",
    signing_salt: "randomsalt"
  plug BEBABEBA_RIDESWeb.Router
end
