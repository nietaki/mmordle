defmodule Mmordle.WordService do
  alias Mmordle.Repo
  alias Mmordle.Schema.Word
  import Ecto.Query

  @spec get_random_word() :: Word.t()
  def get_random_word() do
    query = from Word, order_by: fragment("RANDOM()"), limit: 1
    Repo.one!(query)
  end
end
