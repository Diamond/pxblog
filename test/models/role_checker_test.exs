defmodule Pxblog.RoleCheckerTest do
  use Pxblog.ModelCase
  alias Pxblog.RoleChecker
  alias Pxblog.Factory

  test "is_admin? is true when user has an admin role" do
    role = Factory.create(:role, admin: true)
    user = Factory.create(:user, email: "test@test.com", username: "user", password: "test", password_confirmation: "test", role: role)
    assert RoleChecker.is_admin?(user)
  end

  test "is_admin? is false when user does not have an admin role" do
    role = Factory.create(:role, admin: false)
    user = Factory.create(:user, email: "test@test.com", username: "user", password: "test", password_confirmation: "test", role: role)
    refute RoleChecker.is_admin?(user)
  end
end
