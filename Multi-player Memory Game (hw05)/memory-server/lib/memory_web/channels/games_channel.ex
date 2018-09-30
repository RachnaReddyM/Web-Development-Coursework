defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel
  alias Memory.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = Memory.GameBackup.load(name) || Game.newGame()
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Add authorization logic here as required.
  def authorized?(_payload) do
    true
  end

  def handle_in("double", payload, socket) do
    xx = String.to_integer(payload["xx"])
    resp = %{  "xx" => xx, "yy" => 2 * xx }
    {:reply, {:doubled, resp}, socket}
  end

  def handle_in("gameReset", %{"id" => "reset"}, socket) do
   game = Game.gameReset(socket.assigns[:game],"reset")
   Memory.GameBackup.save(socket.assigns[:name],game)
   socket = assign(socket, :game, game)
   {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  def handle_in("cardFlipped", %{"id" => cardId, "body" => cardValue}, socket) do
    IO.inspect(cardId)
    game = Game.cardFlipped(socket.assigns[:game],cardId,cardValue)
    Memory.GameBackup.save(socket.assigns[:name],game)
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end


end
