defmodule CottonWeb.TShirtLive.FormComponent do
  use CottonWeb, :live_component

  alias Cotton.Shop

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage t_shirt records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="t_shirt-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:price]} type="number" label="Price" />
        <.input field={@form[:stock]} type="number" label="Stock" />
        <.input field={@form[:svg]} type="text" label="Svg" />
        <.input field={@form[:color]} type="text" label="Color" />
        <:actions>
          <.button phx-disable-with="Saving...">Save T shirt</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{t_shirt: t_shirt} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Shop.change_t_shirt(t_shirt))
     end)}
  end

  @impl true
  def handle_event("validate", %{"t_shirt" => t_shirt_params}, socket) do
    changeset = Shop.change_t_shirt(socket.assigns.t_shirt, t_shirt_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"t_shirt" => t_shirt_params}, socket) do
    save_t_shirt(socket, socket.assigns.action, t_shirt_params)
  end

  defp save_t_shirt(socket, :edit, t_shirt_params) do
    case Shop.update_t_shirt(socket.assigns.t_shirt, t_shirt_params) do
      {:ok, t_shirt} ->
        notify_parent({:saved, t_shirt})

        {:noreply,
         socket
         |> put_flash(:info, "T shirt updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_t_shirt(socket, :new, t_shirt_params) do
    case Shop.create_t_shirt(t_shirt_params) do
      {:ok, t_shirt} ->
        notify_parent({:saved, t_shirt})

        {:noreply,
         socket
         |> put_flash(:info, "T shirt created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
