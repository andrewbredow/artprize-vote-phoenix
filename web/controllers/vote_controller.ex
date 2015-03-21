defmodule Artprize.VoteController do
  use Artprize.Web, :controller

  plug :action

  def index(conn, _params) do
    message = GenServer.call(:vote_server, :winner)

    json conn, %{status: "success", message: message}
  end

  def create(conn, params) do
    result = GenServer.call(:vote_server, {:vote, vote_params(params)})
    response = case result do
      {:err, message} ->
        %{status: "error", message: message}
      {:ok, message} ->
        %{status: "success", message: message}
    end

    json conn, response
  end

  defp vote_params(params) do
    to_i = &String.to_integer/1
    to_f = &String.to_float/1
    {
      to_i.(params["user_id"]),
      to_i.(params["entry_id"]),
      {
        to_f.(params["location"]["lat"]),
        to_f.(params["location"]["lng"])
      }
    }
  end
end
