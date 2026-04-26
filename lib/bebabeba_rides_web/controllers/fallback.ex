

defmodule BebabebaBcakend.Web.FallbackController do
  use BebabebaBcakend.Web, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BebabebaBcakend.Web.ErrorView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BebabebaBcakend.Web.ErrorView)
    |> render("error.json", message: "Resource not found")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(BebabebaBcakend.Web.ErrorView)
    |> render("error.json", message: "Unauthorized")
  end

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:bad_request)
    |> put_view(BebabebaBcakend.Web.ErrorView)
    |> render("error.json", message: reason)
  end
end
