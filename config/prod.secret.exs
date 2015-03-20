use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :artprize, Artprize.Endpoint,
  secret_key_base: "yabVCnpTwEnNDu8MZfq0qu56Sr4bnMh93UjfZgn74mOjWPH89Gx29nxKvg+XxtTH"

# Configure your database
config :artprize, Artprize.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "artprize_prod"
