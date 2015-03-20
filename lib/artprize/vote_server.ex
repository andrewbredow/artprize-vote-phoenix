defmodule Artprize.VoteServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], [name: :vote_server])
  end

  def handle_call({:vote, {user_id, entry_id, coordinates}}, _sender, votes) do
    result = add_vote(user_id, entry_id, coordinates, votes)
    {status, message, votes} = result
    {:reply, {status, message}, votes}
  end

  def handle_call(:winner, _sender, votes) do
    result = calculate_winner(votes)
    message = case result do
      {entry_id, vote_count} ->
        "Entry #{entry_id} is winning with #{vote_count} votes!"
      _ ->
        "Not enough votes to compute winner"
    end
    {:reply, message, votes}
  end

  defp add_vote(_, _, {lat, lng}, votes)
  when not lat in -85.726469..-85.55457 or not lng in 42.906554..43.01148 do
    {:err, "You must be in Grand Rapids to vote.", votes}
  end

  defp add_vote(user_id, entry_id, _, votes)
  when is_integer(user_id) and is_integer(entry_id) do
    votes = votes ++ [{user_id, entry_id}]
    {:ok, "Successfully voted for entry, #{entry_id}.", votes}
  end

  def calculate_winner(votes) do
    votes
    |> unique_by_voter_and_entry
    |> sum_per_entry(%{})
    |> order_by_votes
    |> Enum.at(0, %{})
  end

  def unique_by_voter_and_entry(votes), do: Enum.uniq votes

  def sum_per_entry([], sums), do: sums
  def sum_per_entry([{_, entry_id}|tail], sums) do
    initial_value = Dict.get(sums, entry_id, 0)
    sums = Dict.put(sums, entry_id, initial_value + 1)
    sum_per_entry(tail, sums)
  end

  @doc """
  Takes a list of {entry_id, entry_vote_count} tuples and orders them
  in descending order by votes

  # Example

    iex> ArtprizeVote.order_by_votes([{2, 34}, {1, 50}, {3, 2}])
    [{1, 50}, {2, 34}, {3, 2}]

  """
  def order_by_votes(sums) do
    Enum.sort(sums, fn {_, sum_1}, {_, sum_2} -> sum_1 > sum_2 end)
  end
end
