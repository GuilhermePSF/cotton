defmodule CottonWeb.WindowComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div id={@id} class="window" phx-hook="Draggable">
      <div class="title-bar">
        <span><%= @title %></span>
        <button phx-click="close_window" phx-value-id={@id}>[x]</button>
      </div>
      <div class="window-content">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
