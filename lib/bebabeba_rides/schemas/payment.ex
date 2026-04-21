# lib/bebabeba_backend/schemas/payment.ex

defmodule BebabebaBcakend.Schemas.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :decimal
    field :payment_method, :string  # "card", "cash"
    field :status, :string, default: "pending"  # pending, completed, failed
    field :transaction_id, :string

    belongs_to :booking, BebabebaBcakend.Schemas.Booking

    timestamps()
  end

  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:amount, :payment_method, :status, :transaction_id, :booking_id])
    |> validate_required([:amount, :payment_method, :booking_id])
    |> validate_inclusion(:payment_method, ["card", "cash"])
    |> validate_inclusion(:status, ["pending", "completed", "failed"])
    |> validate_number(:amount, greater_than: 0)
    |> foreign_key_constraint(:booking_id)
  end
end
