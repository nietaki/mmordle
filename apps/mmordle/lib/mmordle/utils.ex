defmodule Mmordle.Utils do
  def random_string(length) when is_integer(length) do
    :rand.bytes(length) |> Base.encode16() |> String.slice(0..length)
  end
end
