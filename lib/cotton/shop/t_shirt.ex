defmodule Cotton.Shop.TShirt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tshirts" do
    field :name, :string
    field :description, :string
    field :color, :string
    field :price, :integer
    field :stock, :integer
    field :svg, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(t_shirt, attrs) do
    t_shirt
    |> cast(attrs, [:name, :description, :price, :stock, :svg, :color])
    |> validate_required([:name, :description, :price, :stock, :svg, :color])
  end
end
