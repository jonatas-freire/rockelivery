defmodule Rockelivery.User do

  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:age, :address, :cep, :cpf, :email, :password, :name]

  @required_params_update @required_params -- [:password]

  @derive {Jason.Encoder, only: [ :id, :name, :cpf, :address, :email ]}

  schema "users" do
    field :age, :integer
    field :address, :string
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end


  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 5)
    |> changeset_basic_validation()
    |> put_password_hash()
  end

  def changeset_edit(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params_update)
    |> validate_required(@required_params_update)
    |> changeset_basic_validation()
  end

  defp changeset_basic_validation(struct) do
    struct
    |> validate_length(:cep, is: 8)
    |> validate_length(:cpf, is: 11)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> unique_constraint([:cpf])
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset

end
