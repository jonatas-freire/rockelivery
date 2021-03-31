defmodule Rockelivery.Users.Update do

  alias Rockelivery.{User, Repo, Error}

  def call( %{"id" => id} = params) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found_error() }
      user -> do_update(user, params)
    end

  end

  defp do_update(user, params) do
    user
    |> User.changeset_edit(params)
    |> Repo.update()
  end


end
