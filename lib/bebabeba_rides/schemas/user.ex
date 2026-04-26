
defmodule BebabebaBcakend.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :first_name, :string
    field :last_name, :string
    field :phone, :string

    has_many :bookings, BebabebaBcakend.Schemas.Booking

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :first_name, :last_name, :phone])
    |> validate_required([:email, :password, :first_name, :last_name])
    |> validate_email()
    |> validate_length(:password, min: 6)
    |> hash_password()
    |> unique_constraint(:email)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/@/, message: "invalid email format")
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, hash_pwd_salt(password))
      _ ->
        changeset
    end
  end

  defp hash_pwd_salt(password) do
    Bcrypt.hash_pwd_salt(password)
  end
end
