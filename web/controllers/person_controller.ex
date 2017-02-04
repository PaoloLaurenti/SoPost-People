defmodule SopostPeople.PersonController do
  use SopostPeople.Web, :controller

  alias SopostPeople.Person

  def index(conn, %{"location" => location}) do
    sanitized_location = String.capitalize(location)
    query = from p in Person, where: p.location == ^sanitized_location
    Repo.all(query) |> render_index(conn)
  end

  def index(conn, %{}) do
    Repo.all(Person) |> render_index(conn)
  end

  defp render_index([], conn) do
    render conn, "no_person.html"
  end

  defp render_index(people, conn) do
    render conn, "index.html", people: people
  end

end
