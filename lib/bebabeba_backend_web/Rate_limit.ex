defmodule BebabebaBackendWeb.Plugs.RateLimit do
  import Plug.Conn
  import Phoenix.Controller

  @max_requests 100
  @window_seconds 60

  def init(opts), do: opts

  def call(conn, _opts) do
    ip = get_client_ip(conn)
    key = "rate_limit:#{ip}"

    case Cachex.get(:rate_limit_cache, key) do
      {:ok, count} when is_integer(count) and count >= @max_requests ->
        conn
        |> put_status(:too_many_requests)
        |> put_view(BebabebaBackendWeb.ErrorView)
        |> render("error.json", message: "Too many requests. Please try again later.")
        |> halt()

      {:ok, count} when is_integer(count) ->
        Cachex.incr(:rate_limit_cache, key, 1)
        conn

      _ ->
        Cachex.put(:rate_limit_cache, key, 1,
          expire: :timer.seconds(@window_seconds)
        )

        conn
    end
  end

  defp get_client_ip(conn) do
    case get_req_header(conn, "x-forwarded-for") do
      [ip | _] ->
        ip

      [] ->
        conn.remote_ip
        |> :inet.ntoa()
        |> to_string()
    end
  end
end
