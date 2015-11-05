defmodule Pxblog.Factory do
  use ExMachina.Ecto, repo: Pxblog.Repo

  alias Pxblog.Role
  alias Pxblog.User
  alias Pxblog.Post

  def factory(:role, _attrs) do
    %Role{
      name: sequence(:name, &"Test Role #{&1}"),
      admin: false
    }
  end

  def factory(:user, attrs) do
    %User{
      username: sequence(:username, &"User #{&1}"),
      email: "test@test.com",
      password: "test1234",
      password_confirmation: "test1234",
      password_digest: Comeonin.Bcrypt.hashpwsalt("test1234"),
      role: assoc(attrs, :role)
    }
  end

  def factory(:post, attrs) do
    %Post{
      title: "Some Post",
      body: "And the body of some post",
      user: assoc(attrs, :user)
    }
  end
end
