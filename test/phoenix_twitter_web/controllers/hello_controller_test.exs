defmodule PhoenixTwitterWeb.HelloControllerTest do
  use PhoenixTwitterWeb.ConnCase

  test "GET /hello", %{conn: conn} do
    conn = get(conn, ~p"/hello")
    assert html_response(conn, 200)
  end
end
