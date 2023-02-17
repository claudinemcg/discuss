defmodule DiscussWeb.Topic do
use DiscussWeb, :model # this also creates a struct of the same name %DiscussWeb.Topic{}

  # link to database
  schema "topics" do
    field :title, :string
  end

  # validation
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])         # produces a changeset
    |> validate_required([:title])    # adds errors to changeset
    # returns an updated changeset
  end

end
