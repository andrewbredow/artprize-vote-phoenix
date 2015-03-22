# Artprize Voting App (Phoenix Framework/GenServer version)

## Demo for GRDevDay 2015

See the accompanying slides [here](https://speakerdeck.com/andrewbredow/mix-it-up-with-elixir).

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.

The demo app contains a single endpoint, `/vote` that accepts
a POST to make a new vote, and a GET to see the current winner.

To make a vote, make a post to the API:

```bash
curl -X POST \
  -F user_id=12 \
  -F entry_id=45 \
  -F location[lat]=-85.6 \
  -F location[lng]=43.0 \
  http://localhost:4000/vote
```

When you visit votes in the URL, you should see your vote totals!
