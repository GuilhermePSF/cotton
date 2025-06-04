defmodule Cotton.Shop do
  @moduledoc """
  The Shop context.
  """

  import Ecto.Query, warn: false
  alias Cotton.Repo

  alias Cotton.Shop.TShirt

  @doc """
  Returns the list of tshirts.

  ## Examples

      iex> list_tshirts()
      [%TShirt{}, ...]

  """
  def list_tshirts do
    Repo.all(TShirt)
  end

  @doc """
  Gets a single t_shirt.

  Raises `Ecto.NoResultsError` if the T shirt does not exist.

  ## Examples

      iex> get_t_shirt!(123)
      %TShirt{}

      iex> get_t_shirt!(456)
      ** (Ecto.NoResultsError)

  """
  def get_t_shirt!(id), do: Repo.get!(TShirt, id)

  @doc """
  Creates a t_shirt.

  ## Examples

      iex> create_t_shirt(%{field: value})
      {:ok, %TShirt{}}

      iex> create_t_shirt(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_t_shirt(attrs \\ %{}) do
    %TShirt{}
    |> TShirt.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a t_shirt.

  ## Examples

      iex> update_t_shirt(t_shirt, %{field: new_value})
      {:ok, %TShirt{}}

      iex> update_t_shirt(t_shirt, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_t_shirt(%TShirt{} = t_shirt, attrs) do
    t_shirt
    |> TShirt.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a t_shirt.

  ## Examples

      iex> delete_t_shirt(t_shirt)
      {:ok, %TShirt{}}

      iex> delete_t_shirt(t_shirt)
      {:error, %Ecto.Changeset{}}

  """
  def delete_t_shirt(%TShirt{} = t_shirt) do
    Repo.delete(t_shirt)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking t_shirt changes.

  ## Examples

      iex> change_t_shirt(t_shirt)
      %Ecto.Changeset{data: %TShirt{}}

  """
  def change_t_shirt(%TShirt{} = t_shirt, attrs \\ %{}) do
    TShirt.changeset(t_shirt, attrs)
  end
end
