defmodule Pxblog.Post do
  use Pxblog.Web, :model

  schema "posts" do
    field :title, :string
    field :body, :string
    belongs_to :user, Pxblog.User

    timestamps
  end

  @required_fields ~w(title body)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
