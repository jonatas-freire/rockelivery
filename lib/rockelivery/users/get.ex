defmodule Rockelivery.Users.Get do

  alias Rockelivery.{Repo,User, Error}

  def by_id(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error()}
      user -> {:ok, user}
    end
  end

  def by_email(email) do
    with %User{} = user <- Repo.get_by(User, [email: email ]) do
      {:ok, user}
    else
      :error -> { :error, %{status: :bad_request, result: "Invalid email format!" }}
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end

end
