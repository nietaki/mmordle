defmodule Mmordle.Repo do
  use Ecto.Repo,
    otp_app: :mmordle,
    adapter: Ecto.Adapters.Postgres
end
