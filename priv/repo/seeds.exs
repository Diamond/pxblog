# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pxblog.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Pxblog.Repo
alias Pxblog.Role
alias Pxblog.User

role = %Role{}
  |> Role.changeset(%{name: "Admin Role", admin: true})
  |> Repo.insert!()

admin = %User{}
  |> User.changeset(%{username: "admin", email: "admin@test.com", password: "test", password_confirmation: "test", role_id: role.id})
  |> Repo.insert!()
