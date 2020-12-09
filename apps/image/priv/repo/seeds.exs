# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Image.Repo.insert!(%Image.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Image.Repo.insert!(%Image.Image{ url: "http://placekitten.com/200/300" })
Image.Repo.insert!(%Image.Image{ url: "http://placekitten.com/300/300" })
