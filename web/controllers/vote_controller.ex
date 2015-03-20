defmodule Artprize.VoteController do
  use Artprize.Web, :controller

  plug :action

  def index(conn, _params) do
    message = GenServer.call(:vote_server, :winner)

    json conn, %{status: "success", message: message}
  end

  def create(conn, _params) do
    result = GenServer.call(:vote_server, {:vote, {4, 5, {-85.6, 43}}})
    response = case result do
      {:err, message} ->
        %{status: "error", message: message}
      {:ok, message} ->
        %{status: "success", message: message}
    end

    json conn, response
  end
end
