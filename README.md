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

### What's the word list that you're using?

A combination of Linux's dict and https://en.lexipedia.org/:

```bash
$ cat en_wikt_words_100_5-5.txt | sed "s/ .*$//g" | sort | uniq > wiki_words.txt

$ wc -l wiki_words.txt
8194 wiki_words.txt

$ cat /usr/share/dict/words | grep -P "^[a-z]{5}$" | sort | uniq > dict_words.txt

$ wc -l dict_words.txt
4667 dict_words.txt

$ comm -12 wiki_words.txt dict_words.txt > game_words.txt

$ wc -l game_words.txt 
3213 game_words.txt
```
