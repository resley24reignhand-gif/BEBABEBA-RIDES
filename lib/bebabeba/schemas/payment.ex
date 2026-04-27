defmodule Bebabeba.Schemas.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount,         :decimal
    field :payment_method, :string
    field :status,         :string, default: "pending"
    field :transaction_id, :string

    belongs_to :booking, Bebabeba.Schemas.Booking  # ✅ fixed typo BebabebaBcakend

    timestamps()
  end

  @required_fields ~w(amount payment_method booking_id)a
  @optional_fields ~w(status transaction_id)a

  def changeset(payment, attrs) do
    payment
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:payment_method, ["card", "cash"])
    |> validate_inclusion(:status, ["pending", "completed", "failed"])
    |> validate_number(:amount, greater_than: 0)
    |> foreign_key_constraint(:booking_id)
  end
end
