
defmodule BebabebaBcakend.Web.PaymentController do
  use BebabebaBcakend.Web, :controller

  alias BebabebaBcakend.Payments
  alias BebabebaBcakend.Schemas.Payment

  action_fallback BebabebaBcakend.Web.FallbackController

  def create_payment(conn, %{"payment" => payment_params}) do
    with {:ok, %Payment{} = payment} <- Payments.create_payment(payment_params) do
      conn
      |> put_status(:created)
      |> render("payment.json", payment: payment)
    end
  end

  def get_payment(conn, %{"id" => id}) do
    payment = Payments.get_payment!(id)
    render(conn, "payment.json", payment: payment)
  end

  def process_payment(conn, %{"payment" => payment_params}) do
    with {:ok, %Payment{} = payment} <- Payments.process_payment(payment_params) do
      conn
      |> put_status(:ok)
      |> render("payment.json", payment: payment)
    end
  end

  def get_booking_payment(conn, %{"booking_id" => booking_id}) do
    payment = Payments.get_payment_by_booking(booking_id)
    render(conn, "payment.json", payment: payment)
  end

  def list_payments(conn, %{"user_id" => user_id}) do
    payments = Payments.list_user_payments(user_id)
    render(conn, "payments.json", payments: payments)
  end
end
