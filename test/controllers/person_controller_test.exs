defmodule SopostPeople.PersonControllerTest do
  use SopostPeople.ConnCase

  alias SopostPeople.Person

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "People list"
  end

  test "lists all people on index", %{conn: conn} do
    people_changesets = people() |> Enum.map(&(Person.changeset(%Person{}, &1)))
    Enum.each(people_changesets, &Repo.insert!(&1))

    response = get conn, person_path(conn, :index)

    people() |> assert_all_people_in_response(response)
  end

  test "list people by their location", %{conn: conn} do
    people_changesets = people() |> Enum.map(&(Person.changeset(%Person{}, &1)))
    Enum.each(people_changesets, &Repo.insert!(&1))

    search_location = Enum.at(people_in_location1(), 0).location |> String.upcase
    response = get conn, person_path(conn, :index, %{location: search_location})

    people_in_location1() |> assert_all_people_in_response(response)
    people_in_location2() |> assert_no_people_in_response(response)
  end

  defp people() do
    Enum.concat(people_in_location1(), people_in_location2())
  end

  defp people_in_location1 do
    [ %{name: "Rame1", role: "Role1", location: "Location1", photo: "http://photo1.png" },
      %{name: "Rame3", role: "Role3", location: "Location1", photo: "http://photo3.png" }]
  end

  defp people_in_location2 do
    [ %{name: "Rame2", role: "Role2", location: "Location2", photo: "http://photo2.png" },
      %{name: "Rame4", role: "Role4", location: "Location2", photo: "http://photo4.png" } ]
  end

  defp assert_all_people_in_response(people, response) do
    people
      |> Enum.each(fn(person) ->
        assert html_response(response, 200) =~ person.name
        assert html_response(response, 200) =~ person.role
        assert html_response(response, 200) =~ person.location
        assert html_response(response, 200) =~ person.photo
      end)
  end

  defp assert_no_people_in_response(people, response) do
    people
      |> Enum.each(fn(person) ->
        refute html_response(response, 200) =~ person.name
        refute html_response(response, 200) =~ person.role
        refute html_response(response, 200) =~ person.location
        refute html_response(response, 200) =~ person.photo
      end)
  end
end
