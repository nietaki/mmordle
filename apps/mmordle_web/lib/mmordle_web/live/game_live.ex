defmodule MmordleWeb.Live.GameLive do
  use MmordleWeb, :live_view

  # def render(assigns) do
  #   ~H"""
  #   Current temperature: <%= @temperature %>
  #   """
  # end

  def mount(_params, _session, socket) do
    state = GenServer.call(Mmordle.GameServer, :get_state)
    temperature = 3

    socket =
      socket
      |> assign(:temperature, temperature)
      |> assign(:game_state, state)
      |> assign(:input_id, Mmordle.Utils.random_string(10))

    {:ok, assign(socket, :temperature, temperature)}
  end

  def handle_event("guess_it", value, socket) do
    IO.inspect(value)

    socket =
      case GenServer.call(Mmordle.GameServer, {:guess, value["guess"]}) do
        {:accepted, state} -> assign(socket, :game_state, state)
        {:rejected, state, _reason} -> assign(socket, :game_state, state)
      end

    socket = assign(socket, :input_id, Mmordle.Utils.random_string(10))
    IO.inspect(socket)

    {:noreply, socket}
  end

  def handle_event(name, value, socket) do
    IO.puts("other event")
    IO.inspect(name)
    IO.inspect(value)
    {:noreply, socket}
  end
end
