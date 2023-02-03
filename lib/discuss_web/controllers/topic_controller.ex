defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  # go to discuss_web.ex and take everything in the controller function

  alias DiscussWeb.Topic # model
  # struct = %DiscussWeb.Topic{}
  # changeset = DiscussWeb.Topic.chageset(struct, params)
  # when use alias above can drop DiscussWeb so %Topic{} and Topic.chageset(struct, params)

  def index(conn, _params) do
    topics = Repo.all(Topic)   # Discuss.Repo.all(DiscussWeb.Topic) -> gets everything from database topics
    render(conn, "index.html", topics: topics)
  end

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
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index)) # sending user to index function in topic controller

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do      # (%{"id" => topic_id} = params)
    topic = Repo.get(Topic, topic_id)         # Repo.get finds a single record with the id
    changeset = Topic.changeset(topic)        # only passing in struct, default for params

    render(conn, "edit.html", changeset: changeset, topic: topic)  # adding in topic so when we submit the form
                                                                   # we need to know the id
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do # new topic
    old_topic = Repo.get(Topic, topic_id)             # struct
    changeset = Topic.changeset(old_topic, topic)     # topic has new attributes

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do # id of topic that we weant to delete
    Repo.get!(Topic, topic_id)  |> Repo.delete!
    # use get! because it returns an error e.g. if user tries to delete a topic that doesn't exist, like 422
    # touch database to get record and touch database again to delete it

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end
