# lib/bebabeba_backend/web/plugs/cors.ex

defmodule BebabebaBcakend.Web.Plugs.CORS do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    conn
    |> put_resp_header("access-control-allow-origin", "*")
    |> put_resp_header("access-control-allow-methods", "GET, POST, PUT, DELETE, OPTIONS, PATCH")
    |> put_resp_header("access-control-allow-headers", "Content-Type, Authorization")
    |> put_resp_header("access-control-allow-credentials", "true")
    |> put_resp_header("access-control-max-age", "86400")
    |> handle_preflight()
  end

  defp handle_preflight(conn) do
    case conn.method do
      "OPTIONS" ->
        conn
        |> send_resp(204, "")
        |> halt()

      _ ->
        conn
    end
  end
end
