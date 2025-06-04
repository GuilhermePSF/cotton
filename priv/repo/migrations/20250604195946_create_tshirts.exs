defmodule Cotton.Repo.Migrations.CreateTshirts do
  use Ecto.Migration

  def change do
    create table(:tshirts) do
      add :name, :string
      add :description, :text
      add :price, :integer
      add :stock, :integer
      add :svg, :string
      add :color, :string

      timestamps(type: :utc_datetime)
    end
  end
end
