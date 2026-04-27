# lib/bebabeba_backend/web/controllers/user_controller.ex

defmodule BebabebaBackendWeb.UserController do
  use BebabebaBackendWeb, :controller

  alias BebabebaBackend.Accounts
  alias BebabebaBackend.Schemas.User

  action_fallback BebabebaBackend.Web.FallbackController

  def register(conn, %{"user" => user_params}) do
    with {:ok,%User{} = user} <- Accounts.register_user(user_params) do
      conn
      |> put_status(:created)
      |> render("user.json", user: user)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Accounts.login_user(email, password) do
      conn
      |> put_status(:ok)
      |> render("login.json", user: user, token: token)
    else
      {:error, _reason} ->
        {:error, :unauthorized}
    end
  end

  def get_user(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "user.json", user: user)
  end

  def update_user(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "user.json", user: user)
    end
  end
end
