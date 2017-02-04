defmodule SopostPeople.PersonController do
  use SopostPeople.Web, :controller

  alias SopostPeople.Person

  def index(conn, _params) do
    people = Repo.all(Person)
    render conn, "index.html", people: people
  end
end
