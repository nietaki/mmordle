# Mmordle.Umbrella

To start the dockerised postgres instance

    docker compose up -d

To stop the db and remove its data

    docker compose down -v

To create the db run

    mix ecto.create

Start the Phoenix app with:

    mix phx.server

You can also run your app inside IEx (Interactive Elixir) as:

    iex -S mix phx.server
