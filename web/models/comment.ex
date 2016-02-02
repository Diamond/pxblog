defmodule Pxblog.Comment do
  use Pxblog.Web, :model

  schema "comments" do
    field :author, :string
    field :body, :string
    field :approved, :boolean, default: false
    belongs_to :post, Pxblog.Post

    timestamps
  end

  @required_fields ~w(author body approved)
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
