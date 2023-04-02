defmodule GameoflifeWeb.LifeController do
  use GameoflifeWeb, :live_view

  def mount(_params, _session, socket) do
    send(self(), :tick)
    {:ok, assign(socket, state: Gameoflife.init())}
  end

  def handle_info(:tick, socket) do
    new_state = Gameoflife.next_state(socket.assigns.state)
    new_socket = %{socket | assigns: %{socket.assigns | state: new_state}}
    Process.send_after(self(), :tick, 100)
    {:noreply, new_socket}
  end

  def render(assigns) do
    ~L"""
    <div class="grid grid-cols-10 gap-1">
      <%= for row <- @state do %>
        <%= for cell <- row do %>
          <div class="<%= if cell == 1, do: "bg-black", else: "bg-white" %> w-6 h-6"></div>
        <% end %>
      <% end %>
    </div>
    """
  end
end
