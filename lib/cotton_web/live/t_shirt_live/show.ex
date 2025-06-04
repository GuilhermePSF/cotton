defmodule CottonWeb.TShirtLive.Show do
  use CottonWeb, :live_view

  alias Cotton.Shop

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:t_shirt, Shop.get_t_shirt!(id))}
  end

  defp page_title(:show), do: "Show T shirt"
  defp page_title(:edit), do: "Edit T shirt"
end
