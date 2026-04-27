# lib/bebabeba_backend/web/plugs/auth.ex

defmodule BebabebaBcakend.Web.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias BebabebaBcakend.Accounts

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    token = get_token_from_header(conn)

    case token do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> put_view(BebabebaBcakend.Web.ErrorView)
        |> render("error.json", message: "No authorization token provided")
        |> halt()

      token ->
        case Accounts.verify_token(token) do
          {:ok, user_id} ->
            assign(conn, :current_user_id, user_id)

          {:error, _reason} ->
            conn
            |> put_status(:unauthorized)
            |> put_view(BebabebaBcakend.Web.ErrorView)
            |> render("error.json", message: "Invalid or expired token")
            |> halt()
        end
    end
  end

  defp get_token_from_header(conn) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> token
      _ -> nil
    end
  end
end
