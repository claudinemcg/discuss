defmodule DiscussWeb.Router do
  alias DiscussWeb.TopicController
  alias DiscussWeb.AuthController

  use DiscussWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DiscussWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do      # was 'scope "/", DiscussWeb do' but wasn't working
    pipe_through :browser

    # get "/", PageController, :index
    # this is the first route when someone makes this request, find the Page Controller module and open index
    # break REST convention here, instead of going to PageController, want them to see a list of topics so:

    # get "/topics", TopicController, :index
    # get "/topics/new", TopicController, :new
    # post "/topics", TopicController, :create
    # get "/topics/:id/edit", TopicController, :edit
    # put "/topics/:id", TopicController, :update

    # resources "/topics", TopicController
    resources "/", TopicController  # use instead of routes above, only works when you follow RESTful conventions

    # if you want to have the index page as '/' instead of '/topics' use
    # resources "/", TopicController # then all the routes won't have /topics
  end

  scope "/auth"  do
    pipe_through :browser
    get "/:provider", AuthController, :request
    # handled by the Ueberauth module (in controller plug Ueberauth)
    # when user comes here Ueberauth will intercept it and send them off to Github

    get "/:provider/callback", AuthController, :callback
    # for when user comes back from Github

    #e.g. /auth/github and /auth/github/callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiscussWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DiscussWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
