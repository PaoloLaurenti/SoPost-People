defmodule SopostPeople.PersonController do
  use SopostPeople.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
