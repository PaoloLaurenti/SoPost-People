# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SopostPeople.Repo.insert!(%SopostPeople.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SopostPeople.Repo
alias SopostPeople.Person

Repo.delete_all Person

File.stream!("priv/repo/seed_data.csv")
  |> CSV.decode(headers: true)
  |> Enum.each(fn(row) ->
    Repo.insert!(%Person{
      name: row["name"],
      role: row["role"],
      location: row["location"],
      photo: row["photo"]
      })
  end)
