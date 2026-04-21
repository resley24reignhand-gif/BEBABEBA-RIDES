# lib/bebabeba_backend/schemas/vehicle.ex

defmodule BebabebaBcakend.Schemas.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vehicles" do
    field :vehicle_type, :string  # "minivan", "van", "bus"
    field :capacity, :integer
    field :price_per_km, :decimal
    field :description, :string
    field :image_url, :string
    field :status, :string, default: "available"  # available, unavailable

    has_many :bookings, BebabebaBcakend.Schemas.Booking

    timestamps()
  end

  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, [:vehicle_type, :capacity, :price_per_km, :description, :image_url, :status])
    |> validate_required([:vehicle_type, :capacity, :price_per_km])
    |> validate_inclusion(:vehicle_type, ["minivan", "van", "bus"])
    |> validate_number(:capacity, greater_than: 0)
    |> validate_number(:price_per_km, greater_than: 0)
    |> validate_inclusion(:status, ["available", "unavailable"])
  end
end
