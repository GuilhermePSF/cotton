defmodule CottonWeb.TShirtLiveTest do
  use CottonWeb.ConnCase

  import Phoenix.LiveViewTest
  import Cotton.ShopFixtures

  @create_attrs %{name: "some name", description: "some description", color: "some color", price: 42, stock: 42, svg: "some svg"}
  @update_attrs %{name: "some updated name", description: "some updated description", color: "some updated color", price: 43, stock: 43, svg: "some updated svg"}
  @invalid_attrs %{name: nil, description: nil, color: nil, price: nil, stock: nil, svg: nil}

  defp create_t_shirt(_) do
    t_shirt = t_shirt_fixture()
    %{t_shirt: t_shirt}
  end

  describe "Index" do
    setup [:create_t_shirt]

    test "lists all tshirts", %{conn: conn, t_shirt: t_shirt} do
      {:ok, _index_live, html} = live(conn, ~p"/tshirts")

      assert html =~ "Listing Tshirts"
      assert html =~ t_shirt.name
    end

    test "saves new t_shirt", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tshirts")

      assert index_live |> element("a", "New T shirt") |> render_click() =~
               "New T shirt"

      assert_patch(index_live, ~p"/tshirts/new")

      assert index_live
             |> form("#t_shirt-form", t_shirt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#t_shirt-form", t_shirt: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tshirts")

      html = render(index_live)
      assert html =~ "T shirt created successfully"
      assert html =~ "some name"
    end

    test "updates t_shirt in listing", %{conn: conn, t_shirt: t_shirt} do
      {:ok, index_live, _html} = live(conn, ~p"/tshirts")

      assert index_live |> element("#tshirts-#{t_shirt.id} a", "Edit") |> render_click() =~
               "Edit T shirt"

      assert_patch(index_live, ~p"/tshirts/#{t_shirt}/edit")

      assert index_live
             |> form("#t_shirt-form", t_shirt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#t_shirt-form", t_shirt: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tshirts")

      html = render(index_live)
      assert html =~ "T shirt updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes t_shirt in listing", %{conn: conn, t_shirt: t_shirt} do
      {:ok, index_live, _html} = live(conn, ~p"/tshirts")

      assert index_live |> element("#tshirts-#{t_shirt.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tshirts-#{t_shirt.id}")
    end
  end

  describe "Show" do
    setup [:create_t_shirt]

    test "displays t_shirt", %{conn: conn, t_shirt: t_shirt} do
      {:ok, _show_live, html} = live(conn, ~p"/tshirts/#{t_shirt}")

      assert html =~ "Show T shirt"
      assert html =~ t_shirt.name
    end

    test "updates t_shirt within modal", %{conn: conn, t_shirt: t_shirt} do
      {:ok, show_live, _html} = live(conn, ~p"/tshirts/#{t_shirt}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit T shirt"

      assert_patch(show_live, ~p"/tshirts/#{t_shirt}/show/edit")

      assert show_live
             |> form("#t_shirt-form", t_shirt: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#t_shirt-form", t_shirt: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/tshirts/#{t_shirt}")

      html = render(show_live)
      assert html =~ "T shirt updated successfully"
      assert html =~ "some updated name"
    end
  end
end
