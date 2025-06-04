defmodule Cotton.ShopFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cotton.Shop` context.
  """

  @doc """
  Generate a t_shirt.
  """
  def t_shirt_fixture(attrs \\ %{}) do
    {:ok, t_shirt} =
      attrs
      |> Enum.into(%{
        color: "some color",
        description: "some description",
        name: "some name",
        price: 42,
        stock: 42,
        svg: "some svg"
      })
      |> Cotton.Shop.create_t_shirt()

    t_shirt
  end
end
