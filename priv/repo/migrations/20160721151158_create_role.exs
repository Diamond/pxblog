defmodule Pxblog.Repo.Migrations.CreateRole do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :admin, :boolean, default: false, null: false

      timestamps()
    end

  end
end
