defmodule SopostPeople.PersonControllerTest do
  use SopostPeople.ConnCase

  alias SopostPeople.Person

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "People list"
  end

  test "lists all people on index", %{conn: conn} do
    people = [ %{name: "name1", role: "role1", location: "location1", photo: "http://photo1.png" },
               %{name: "name2", role: "role2", location: "location2", photo: "http://photo2.png" } ]
    people_changesets = people |> Enum.map(&(Person.changeset(%Person{}, &1)))
    Enum.each(people_changesets, &Repo.insert!(&1))

    response = get conn, person_path(conn, :index)

    people
      |> Enum.each(fn(person) ->
        assert html_response(response, 200) =~ person.name
        assert html_response(response, 200) =~ person.role
        assert html_response(response, 200) =~ person.location
        assert html_response(response, 200) =~ person.photo
      end)
  end
end
