defmodule CottonWeb.PageLive do
  use CottonWeb, :live_view
  import CottonWeb.WindowComponent

  def mount(_params, _session, socket) do
    {:ok, assign(socket, windows: [])}
  end

  def handle_event("add_window", _params, socket) do
    new_id = Enum.count(socket.assigns.windows) + 1

    new_window = %{id: new_id}
    windows = socket.assigns.windows ++ [new_window]

    {:noreply, assign(socket, windows: windows)}
  end


  def handle_event("open_window", _params, socket) do
    {:noreply, assign(socket, show_window: true)}
  end

  def handle_event("close_window", %{"id" => _id}, socket) do
    {:noreply, assign(socket, show_window: false)}
  end

  def render(assigns) do
    ~H"""
    <div class="p-4">
      <h1 class="text-xl font-bold">Windows</h1>

      <button phx-click="add_window" class="mt-2 px-4 py-2 bg-blue-500 text-white rounded">
        Add Window
      </button>

      <div class="mt-4 space-y-2">
        <%= for window <- @windows do %>
          <div class="border p-2 rounded shadow">
            <strong>Window <%= window.id %></strong>
          </div>
        <% end %>
      </div>
    </div>
    """
  end


end
