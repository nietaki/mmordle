# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mmordle.Repo.insert!(%Mmordle.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Mmordle.Repo
alias Mmordle.Schema.Word

IO.puts(File.cwd!())

File.stream!("apps/mmordle/priv/game_words.txt")
|> Stream.map(&String.trim/1)
|> Stream.map(fn word -> Word.changeset(%Word{}, %{word: word}) end)
|> Enum.each(fn changeset ->
  Repo.insert!(changeset, on_conflict: :replace_all, conflict_target: [:word])
end)
