defmodule Bebabeba.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email,         :string
    field :password_hash, :string
    field :password,      :string, virtual: true
    field :first_name,    :string
    field :last_name,     :string
    field :phone,         :string
    field :is_admin,      :boolean, default: false

    has_many :bookings, Bebabeba.Schemas.Booking

    timestamps()
  end

  @required_fields ~w(email password first_name last_name)a
  @optional_fields ~w(phone is_admin)a

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+\.[^\s]+$/, message: "invalid email format")
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end
  defp hash_password(changeset), do: changeset
end
