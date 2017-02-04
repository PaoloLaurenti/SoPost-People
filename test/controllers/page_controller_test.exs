defmodule SopostPeople.PersonControllerTest do
  use SopostPeople.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "SoPost people list"
  end
end
