defmodule Pxblog.RoleChecker do
  alias Pxblog.Repo
  alias Pxblog.Role

  def is_admin?(user) do
    (role = Repo.get(Role, user.role_id)) && role.admin
  end
end
