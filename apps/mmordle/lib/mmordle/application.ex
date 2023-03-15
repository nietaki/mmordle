defmodule Mmordle.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Mmordle.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mmordle.PubSub},
      # Start Finch
      {Finch, name: Mmordle.Finch},
      # Start a worker by calling: Mmordle.Worker.start_link(arg)
      # {Mmordle.Worker, arg}
      {Mmordle.GameServer, initial_target: "words", name: Mmordle.GameServer}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Mmordle.Supervisor)
  end
end
