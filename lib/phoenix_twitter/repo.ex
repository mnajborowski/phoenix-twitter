defmodule PhoenixTwitter.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_twitter,
    adapter: Ecto.Adapters.Postgres
end
