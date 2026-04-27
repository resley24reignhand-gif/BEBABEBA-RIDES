# lib/bebabeba_backend/web/plugs/admin.ex

defmodule BebabebaBcakend.Web.Plugs.Admin do
  import Plug.Conn
  import Phoenix.Controller

  alias BebabebaBcakend.Accounts

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user_id = conn.assigns[:current_user_id]

    if user_id do
      user = Accounts.get_user!(user_id)

      if user.is_admin do
        conn
      else
        conn
        |> put_status(:forbidden)
        |> put_view(BebabebaBcakend.Web.ErrorView)
        |> render("error.json", message: "Admin access required")
        |> halt()
      end
    else
      conn
      |> put_status(:unauthorized)
      |> put_view(BebabebaBcakend.Web.ErrorView)
      |> render("error.json", message: "Not authenticated")
      |> halt()
    end
  end
end
