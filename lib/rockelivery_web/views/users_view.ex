defmodule RockeliveryWeb.UsersView do
  use RockeliveryWeb, :view

  alias Rockelivery.User
  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created",
      content: user
    }
  end

  def render("user.json", %{user: %User{} = user}) do
  %{
    message: "User #{user.id} found",
    content: user
  }
  end

  def render("delete.json", %{user: %User{} = user}) do
   %{
    message: "User #{user.id} deleted",
    content: user
  }
  end

end
