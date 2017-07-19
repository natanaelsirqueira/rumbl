defmodule Rumbl.Video do
  use Rumbl.Web, :model

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Rumbl.User
    belongs_to :category, Rumbl.Category, on_replace: :nilify # anulates the existent relationship

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, category, params \\ %{}) do
    IO.inspect category
    struct
    |> cast(params, [:url, :title, :description])
    |> validate_required([:url, :title, :description])
    |> assoc_constraint(:category)
    |> put_assoc(:category, category)
  end
end
