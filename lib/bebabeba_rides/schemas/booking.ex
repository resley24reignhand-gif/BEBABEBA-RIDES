# lib/bebabeba_backend/schemas/booking.ex

defmodule BebabebaBcakend.Schemas.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field :pickup_location, :string
    field :dropoff_location, :string
    field :journey_type, :string  # "short", "long"
    field :distance_km, :decimal
    field :passenger_count, :integer
    field :total_cost, :decimal
    field :status, :string, default: "pending"  # pending, confirmed, completed, cancelled
    field :scheduled_at, :naive_datetime

    belongs_to :user, BebabebaBcakend.Schemas.User
    belongs_to :vehicle, BebabebaBcakend.Schemas.Vehicle
    has_one :payment, BebabebaBcakend.Schemas.Payment

    timestamps()
  end

  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:pickup_location, :dropoff_location, :journey_type, :distance_km, :passenger_count, :total_cost, :status, :scheduled_at, :user_id, :vehicle_id])
    |> validate_required([:pickup_location, :dropoff_location, :journey_type, :distance_km, :passenger_count, :user_id, :vehicle_id, :scheduled_at])
    |> validate_inclusion(:journey_type, ["short", "long"])
    |> validate_number(:distance_km, greater_than: 0)
    |> validate_number(:passenger_count, greater_than: 0)
    |> validate_inclusion(:status, ["pending", "confirmed", "completed", "cancelled"])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:vehicle_id)
  end
end
