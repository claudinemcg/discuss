defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller # tell phoenix to configure this module as a controller
  plug Ueberauth

  def callback(conn, params) do   # Ueberauth expects a callback function
  # params:
  # %{
  #   "code" => "a750c08cde5a5165db8d",
  #   "provider" => "github",
  #   "state" => "QLEMF7uFitnic9mKRR4mQQxZ"
  # }

  IO.puts("++++++++++++++++++")
    IO.inspect(conn.assigns)
    IO.inspect(params)
    IO.puts("++++++++++++++++++")
  end






end
