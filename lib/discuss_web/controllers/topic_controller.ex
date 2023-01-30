defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  # go to discuss_web.ex and take everything in the controller function

  alias DiscussWeb.Topic # model
  # struct = %DiscussWeb.Topic{}
  # changeset = DiscussWeb.Topic.chageset(struct, params)
  # when use alias above can drop DiscussWeb so %Topic{} and Topic.chageset(struct, params)

  def new(conn, _params) do
    # struct = %Topic{}
    # params = %{}
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
    # in render can pass in any type of custom data e.g. changeset: changeset, so in new.html -> @changeset will reference this
  end

  def create(conn, %{"topic" => topic}) do   # %{"topic" => topic} = params -> pattern matching on params
    changeset = Topic.changeset(%Topic{}, topic) # empty struct becasue we are creating it from sctatch. topic from params

    case Repo.insert(changeset)  do         # added alias Discuss.Repo to def controller in discuss_web.ex so
                                            # all controller have it
      {:ok, post} -> IO.inspect(post)
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
