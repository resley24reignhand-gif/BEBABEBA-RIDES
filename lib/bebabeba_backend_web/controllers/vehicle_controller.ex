defmodule BebabebaBackendWeb.Plugs.RateLimit do
  import Plug.Conn

  @max_requests 5

  def init(opts), do: opts

  def call(conn, _opts) do
    count = Process.get(:request_count, 0)

    if count >= @max_requests do
      conn
      |> send_resp(429, "Too many requests")
      |> halt()
    else
      Process.put(:request_count, count + 1)
      conn
    end
  end
end
