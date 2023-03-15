defmodule Mmordle.GameServer do
  alias Mmordle.GameState

  use GenServer

  def start_link(opts) when is_list(opts) do
    word = Keyword.get(opts, :initial_target, "words")

    # this allows us to name the server for example
    other_opts = Keyword.drop(opts, [:initial_target])
    GenServer.start_link(__MODULE__, word, other_opts)
  end

  # Callbacks

  @impl true
  def init(word) do
    state = GameState.new!(word)
    {:ok, state}
  end

  @impl true
  def handle_call({:guess, word}, _from, %GameState{} = state) do
    if GameState.finished?(state) do
      {:error, "game is finished"}
    else
      case GameState.guess(state, word) do
        {:ok, state} -> {:reply, {:accepted, state}, state}
        {:error, reason} -> {:reply, {:rejected, state, reason}, state}
      end
    end
  end

  def handle_call({:new_game, target}, _from, %GameState{} = state) do
    case GameState.new(target) do
      {:ok, state} -> {:reply, {:accepted, state}, state}
      {:error, reason} -> {:reply, {:rejected, state, reason}, state}
    end
  end

  @impl true
  def handle_call(:get_state, _from, %GameState{} = state) do
    {:reply, state, state}
  end
end
