defmodule Mmordle.GameStateTest do
  use ExUnit.Case
  alias Mmordle.GameState
  doctest GameState

  describe "new!" do
    test "works on a 5 character word" do
      assert %GameState{target: "fooba", guesses: []} == GameState.new!("fooba")
    end

    test "explodes on an incorrect argument" do
      assert_raise FunctionClauseError, fn ->
        GameState.new!(1)
      end
    end
  end

  describe "finished?" do
    test "works when the target was guessed" do
      assert GameState.finished?(%GameState{target: "fooba", guesses: ["fooba"]})
      assert GameState.finished?(%GameState{target: "fooba", guesses: ["fooba", "others"]})
    end

    test "works when the target wasn't guessed" do
      refute GameState.finished?(%GameState{target: "xenon", guesses: []})
      refute GameState.finished?(%GameState{target: "xenon", guesses: ["fooba"]})
      refute GameState.finished?(%GameState{target: "xenon", guesses: ["others", "fooba"]})
    end
  end
end
