defmodule Bebabeba.Schemas.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field :pickup_location,  :string
    field :dropoff_location, :string
    field :journey_type,     :string
    field :distance_km,      :decimal
    field :passenger_count,  :integer
    field :total_cost,       :decimal
    field :status,           :string, default: "pending"
    field :scheduled_at,     :naive_datetime

    belongs_to :user,    Bebabeba.Schemas.User     # ✅ fixed typo BebabebaBakend
    belongs_to :vehicle, Bebabeba.Schemas.Vehicle
    has_one    :payment, Bebabeba.Schemas.Payment

    timestamps()
  end

  @required_fields ~w(pickup_location dropoff_location journey_type distance_km
                      passenger_count user_id vehicle_id scheduled_at)a
  @optional_fields ~w(total_cost status)a

  def changeset(booking, attrs) do
    booking
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:journey_type, ["short", "long"])
    |> validate_number(:distance_km, greater_than: 0)
    |> validate_number(:passenger_count, greater_than: 0)
    |> validate_inclusion(:status, ["pending", "confirmed", "completed", "cancelled"])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:vehicle_id)
  end
end
