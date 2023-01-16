defmodule DiscussWeb.Topic do
use DiscussWeb, :model
  # link to database
  schema "topics" do
    field :title, :string
  end

  # validation
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end

end
