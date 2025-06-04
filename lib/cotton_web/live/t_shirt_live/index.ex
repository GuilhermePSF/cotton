defmodule CottonWeb.TShirtLive.Index do
  use CottonWeb, :live_view

  alias Cotton.Shop
  alias Cotton.Shop.TShirt

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :tshirts, Shop.list_tshirts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit T shirt")
    |> assign(:t_shirt, Shop.get_t_shirt!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New T shirt")
    |> assign(:t_shirt, %TShirt{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tshirts")
    |> assign(:t_shirt, nil)
  end

  @impl true
  def handle_info({CottonWeb.TShirtLive.FormComponent, {:saved, t_shirt}}, socket) do
    {:noreply, stream_insert(socket, :tshirts, t_shirt)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    t_shirt = Shop.get_t_shirt!(id)
    {:ok, _} = Shop.delete_t_shirt(t_shirt)

    {:noreply, stream_delete(socket, :tshirts, t_shirt)}
  end
end
