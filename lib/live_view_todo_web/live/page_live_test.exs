defmodule LiveViewTodoWeb.PageLiveTest do
  use LiveViewTodoWeb.ConnCase
  import Phoenix.LiveViewTest
  test "disconected and connected mount", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Disconnected"
    assert render(page_live) =~ "What needs to be done"
  end
end
