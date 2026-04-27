# lib/bebabeba_backend/web/plugs/validate_request.ex

defmodule BebabebaBcakend.Web.Plugs.ValidateRequest do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case conn.method do
      "POST" -> validate_json(conn)
      "PUT" -> validate_json(conn)
      "PATCH" -> validate_json(conn)
      _ -> conn
    end
  end

  defp validate_json(conn) do
    case get_req_header(conn, "content-type") do
      ["application/json" <> _] -> conn
      _ ->
        conn
        |> put_status(:unsupported_media_type)
        |> put_view(BebabebaBcakend.Web.ErrorView)
        |> render("error.json", message: "Content-Type must be application/json")
        |> halt()
    end
  end
end
