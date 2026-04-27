defmodule Bebabeba.Schemas.Vehicle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vehicles" do
    field :vehicle_type,  :string
    field :capacity,      :integer
    field :price_per_km,  :decimal
    field :description,   :string
    field :image_url,     :string
    field :status,        :string, default: "available"

    has_many :bookings, Bebabeba.Schemas.Booking

    timestamps()
  end

  @required_fields ~w(vehicle_type capacity price_per_km)a
  @optional_fields ~w(description image_url status)a

  def changeset(vehicle, attrs) do
    vehicle
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:vehicle_type, ["minivan", "van", "bus"])
    |> validate_number(:capacity, greater_than: 0)
    |> validate_number(:price_per_km, greater_than: 0)
    |> validate_inclusion(:status, ["available", "unavailable"])
  end
end
