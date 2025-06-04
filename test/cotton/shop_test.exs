defmodule Cotton.ShopTest do
  use Cotton.DataCase

  alias Cotton.Shop

  describe "tshirts" do
    alias Cotton.Shop.TShirt

    import Cotton.ShopFixtures

    @invalid_attrs %{name: nil, description: nil, color: nil, price: nil, stock: nil, svg: nil}

    test "list_tshirts/0 returns all tshirts" do
      t_shirt = t_shirt_fixture()
      assert Shop.list_tshirts() == [t_shirt]
    end

    test "get_t_shirt!/1 returns the t_shirt with given id" do
      t_shirt = t_shirt_fixture()
      assert Shop.get_t_shirt!(t_shirt.id) == t_shirt
    end

    test "create_t_shirt/1 with valid data creates a t_shirt" do
      valid_attrs = %{name: "some name", description: "some description", color: "some color", price: 42, stock: 42, svg: "some svg"}

      assert {:ok, %TShirt{} = t_shirt} = Shop.create_t_shirt(valid_attrs)
      assert t_shirt.name == "some name"
      assert t_shirt.description == "some description"
      assert t_shirt.color == "some color"
      assert t_shirt.price == 42
      assert t_shirt.stock == 42
      assert t_shirt.svg == "some svg"
    end

    test "create_t_shirt/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shop.create_t_shirt(@invalid_attrs)
    end

    test "update_t_shirt/2 with valid data updates the t_shirt" do
      t_shirt = t_shirt_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", color: "some updated color", price: 43, stock: 43, svg: "some updated svg"}

      assert {:ok, %TShirt{} = t_shirt} = Shop.update_t_shirt(t_shirt, update_attrs)
      assert t_shirt.name == "some updated name"
      assert t_shirt.description == "some updated description"
      assert t_shirt.color == "some updated color"
      assert t_shirt.price == 43
      assert t_shirt.stock == 43
      assert t_shirt.svg == "some updated svg"
    end

    test "update_t_shirt/2 with invalid data returns error changeset" do
      t_shirt = t_shirt_fixture()
      assert {:error, %Ecto.Changeset{}} = Shop.update_t_shirt(t_shirt, @invalid_attrs)
      assert t_shirt == Shop.get_t_shirt!(t_shirt.id)
    end

    test "delete_t_shirt/1 deletes the t_shirt" do
      t_shirt = t_shirt_fixture()
      assert {:ok, %TShirt{}} = Shop.delete_t_shirt(t_shirt)
      assert_raise Ecto.NoResultsError, fn -> Shop.get_t_shirt!(t_shirt.id) end
    end

    test "change_t_shirt/1 returns a t_shirt changeset" do
      t_shirt = t_shirt_fixture()
      assert %Ecto.Changeset{} = Shop.change_t_shirt(t_shirt)
    end
  end
end
