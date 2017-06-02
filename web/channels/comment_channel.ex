defmodule Pxblog.CommentChannel do
  use Pxblog.Web, :channel
  alias Pxblog.CommentHelper

  require Logger

  def join("comments:" <> _comment_id, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (comment:lobby).
  def handle_in("CREATED_COMMENT", payload, socket) do
    case CommentHelper.create(payload, socket) do
      {:ok, comment} ->
        broadcast socket, "CREATED_COMMENT", Map.merge(payload, %{insertedAt: comment.inserted_at, commentId: comment.id, approved: comment.approved})
        {:noreply, socket}
      {:error, message} ->
        {:noreply, socket}
    end
  end

  def handle_in("APPROVED_COMMENT", payload, socket) do
    case CommentHelper.approve(payload, socket) do
      {:ok, comment} ->
        new_payload = payload
          |> Map.merge(%{
            insertedAt: comment.inserted_at,
            commentId: comment.id,
            approved: comment.approved
          })
        broadcast socket, "APPROVED_COMMENT", new_payload
        {:noreply, socket}
      {:error, _} ->
        {:noreply, socket}
    end
  end

  def handle_in("DELETED_COMMENT", payload, socket) do
    case CommentHelper.delete(payload, socket) do
      {:ok, _} ->
        broadcast socket, "DELETED_COMMENT", payload
        {:noreply, socket}
      {:error, _} ->
        {:noreply, socket}
    end
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
