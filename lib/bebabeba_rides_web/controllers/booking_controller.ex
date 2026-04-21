# lib/bebabeba_backend/web/controllers/booking_controller.ex

defmodule BebabebaBcakend.Web.BookingController do
  use BebabebaBcakend.Web, :controller

  alias BebabebaBcakend.Bookings
  alias BebabebaBcakend.Schemas.Booking

  action_fallback BebabebaBcakend.Web.FallbackController

  def create_booking(conn, %{"booking" => booking_params}) do
    with {:ok, %Booking{} = booking} <- Bookings.create_booking(booking_params) do
      conn
      |> put_status(:created)
      |> render("booking.json", booking: booking)
    end
  end

  def get_booking(conn, %{"id" => id}) do
    booking = Bookings.get_booking!(id)
    render(conn, "booking.json", booking: booking)
  end

  def list_user_bookings(conn, %{"user_id" => user_id}) do
    bookings = Bookings.list_user_bookings(user_id)
    render(conn, "bookings.json", bookings: bookings)
  end

  def update_booking(conn, %{"id" => id, "booking" => booking_params}) do
    booking = Bookings.get_booking!(id)

    with {:ok, %Booking{} = booking} <- Bookings.update_booking(booking, booking_params) do
      render(conn, "booking.json", booking: booking)
    end
  end

  def cancel_booking(conn, %{"id" => id}) do
    booking = Bookings.get_booking!(id)

    with {:ok, %Booking{} = booking} <- Bookings.cancel_booking(booking) do
      render(conn, "booking.json", booking: booking)
    end
  end

  def calculate_cost(conn, %{"vehicle_id" => vehicle_id, "distance_km" => distance_km, "passenger_count" => passenger_count}) do
    cost = Bookings.calculate_booking_cost(vehicle_id, distance_km, passenger_count)
    render(conn, "cost.json", cost: cost)
  end
end
