defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  # go to discuss_web.ex and take everything in the controller function

  alias DiscussWeb.Topic
  # struct = %DiscussWeb.Topic{}
  # changeset = DiscussWeb.Topic.chageset(struct, params)

  def new(conn, params) do
    # struct = %Topic{}
    # params = %{}
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end
end
