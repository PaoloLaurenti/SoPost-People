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

    people()
      |> Enum.each(fn(person) ->
        assert html_response(response, 200) =~ person.name
        assert html_response(response, 200) =~ person.role
        assert html_response(response, 200) =~ person.location
        assert html_response(response, 200) =~ person.photo
      end)
  end

  test "list people by their location", %{conn: conn} do
    people_changesets = people() |> Enum.map(&(Person.changeset(%Person{}, &1)))
    Enum.each(people_changesets, &Repo.insert!(&1))

    response = get conn, person_path(conn, :index, %{location: "location1"})

    people()
      |> Enum.filter(fn(person) -> person.location == "location1" end)
      |> Enum.each(fn(person) ->
        assert html_response(response, 200) =~ person.name
        assert html_response(response, 200) =~ person.role
        assert html_response(response, 200) =~ person.location
        assert html_response(response, 200) =~ person.photo
      end)
      refute html_response(response, 200) =~ "name2"
      refute html_response(response, 200) =~ "role2"
      refute html_response(response, 200) =~ "location2"
      refute html_response(response, 200) =~ "http://photo2.png"
  end

  defp people() do
    [ %{name: "name1", role: "role1", location: "location1", photo: "http://photo1.png" },
      %{name: "name2", role: "role2", location: "location2", photo: "http://photo2.png" },
      %{name: "name3", role: "role3", location: "location1", photo: "http://photo3.png" }]
  end
end
