defmodule Pxblog.UserTest do
  use Pxblog.ModelCase

  alias Pxblog.User

  @valid_attrs %{email: "test@test.com", username: "test", password: "test", password_confirmation: "test"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "password_digest value gets set to a hash" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert Comeonin.Bcrypt.checkpw(@valid_attrs.password, Ecto.Changeset.get_change(changeset, :password_digest))
  end

  test "password_digest value does not get set if password is nil" do
    changeset = User.changeset(%User{}, %{email: "test@test.com", password: nil, password_confirmation: nil, username: "test"})
    refute Ecto.Changeset.get_change(changeset, :password_digest)
  end

  test "changeset is invalid if password and confirmation do not match" do
    changeset = User.changeset(%User{}, %{email: "test@test.com", password: "foo", password_confirmation: "bar", username: "test"})
    refute changeset.valid?
    assert changeset.errors[:password_confirmation] == "does not match password!"
  end

  test "changeset is invalid if username is used already" do
    %User{}
    |> User.changeset(@valid_attrs)
    |> Pxblog.Repo.insert!
    user2 =
      %User{}
      |> User.changeset(@valid_attrs)
    assert {:error, changeset} = Repo.insert(user2)
    assert changeset.errors[:username] == "has already been taken"
  end

  test "changeset is invalid if email is used already" do
    user2_attrs = @valid_attrs |> Map.put(:username, "test2")
    %User{}
    |> User.changeset(@valid_attrs)
    |> Pxblog.Repo.insert!
    user2 =
      %User{}
      |> User.changeset(user2_attrs)
    assert {:error, changeset} = Repo.insert(user2)
    assert changeset.errors[:email] == "has already been taken"
  end

  test "changeset is invalid if password is too short" do
    attrs = @valid_attrs |> Map.put(:password, "t") |> Map.put(:password_confirmation, "t")
    changeset =
      %User{}
      |> User.changeset(attrs)
    refute changeset.valid?
    assert Dict.has_key?(changeset.errors, :password)
  end
end
