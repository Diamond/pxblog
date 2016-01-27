defmodule Pxblog.UserTest do
  use Pxblog.ModelCase

  alias Pxblog.User
  alias Pxblog.Factory

  @valid_attrs %{email: "test@test.com", password: "test1234", password_confirmation: "test1234", username: "testuser"}
  @invalid_attrs %{}

  setup do
    role = Factory.create(:role, admin: false)
    {:ok, role: role}
  end

  defp valid_attrs(role) do
    Map.put(@valid_attrs, :role_id, role.id)
  end

  test "changeset with valid attributes", %{role: role} do
    changeset = User.changeset(%User{}, valid_attrs(role))
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

  test "changeset is invalid if password and confirmation do not match" do
    changeset = User.changeset(%User{}, %{email: "test@test.com", password: "foo", password_confirmation: "bar", username: "test"})
    refute changeset.valid?
  end
end
