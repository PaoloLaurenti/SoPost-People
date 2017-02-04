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

    people_in_location1()
      |> Enum.each(fn(person) ->
        assert html_response(response, 200) =~ person.name
        assert html_response(response, 200) =~ person.role
        assert html_response(response, 200) =~ person.location
        assert html_response(response, 200) =~ person.photo
      end)
    people_in_location2()
      |> Enum.each(fn(person) ->
        refute html_response(response, 200) =~ person.name
        refute html_response(response, 200) =~ person.role
        refute html_response(response, 200) =~ person.location
        refute html_response(response, 200) =~ person.photo
      end)
  end

  defp people() do
    Enum.concat(people_in_location1(), people_in_location2())
  end

  defp people_in_location1 do
    [ %{name: "name1", role: "role1", location: "location1", photo: "http://photo1.png" },
      %{name: "name3", role: "role3", location: "location1", photo: "http://photo3.png" }]
  end

  defp people_in_location2 do
    [ %{name: "name2", role: "role2", location: "location2", photo: "http://photo2.png" },
      %{name: "name4", role: "role4", location: "location2", photo: "http://photo4.png" } ]
  end
end
