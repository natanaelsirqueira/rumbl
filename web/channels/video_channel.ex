defmodule Rumbl.VideoChannel do
  use Rumbl.Web, :channel

  def join("videos:" <> video_id, _params, socket) do
    {:ok, assign(socket, :message_count, 0)}
  end

  def handle_in("new_annotation", params, socket) do
    socket = assign(socket, :message_count, socket.assigns.message_count + 1)

    broadcast!(socket, "annotation_added", %{
      user: %{username: "anon"},
      body: "#{socket.assigns.message_count} - #{params["body"]}",
      at: params["at"]
    })

    {:reply, :ok, socket}
  end
end
