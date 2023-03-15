defmodule Mmordle.GameState do
  use TypedStruct

  typedstruct do
    @typedoc """
    NOTE: guesses are in the reverse order: newest first
    """
    field :target, String.t(), enforce: true

    field :guesses, [String.t()], default: []
  end

  @spec new!(String.t()) :: t()
  def new!(word) when is_binary(word) and byte_size(word) == 5 do
    {:ok, state} = new(word)
    state
  end

  @spec new(String.t()) :: {:ok, t()} | {:error, binary()}
  def new(word) when is_binary(word) and byte_size(word) == 5 do
    {:ok, %__MODULE__{target: word}}
  end

  def new(_word) do
    {:error, "invalid word"}
  end

  @spec finished?(t()) :: boolean
  def finished?(%__MODULE__{target: word, guesses: guesses}) do
    Enum.at(guesses, 0) == word
  end

  @spec guess(t(), String.t()) :: {:ok, t()} | {:error, binary()}
  def guess(state, word) when is_binary(word) and byte_size(word) == 5 do
    {:ok, %{state | guesses: [word | state.guesses]}}
  end

  def guess(_, _) do
    {:error, "invalid guess"}
  end
end
