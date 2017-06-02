defmodule Pxblog.CommentChannelTest do
  use Pxblog.ChannelCase

  alias Pxblog.CommentChannel
  import Pxblog.Factory

  setup do
    user    = insert(:user)
    post    = insert(:post, user: user)
    comment = insert(:comment, post: post, approved: false)

    {:ok, _, socket} =
      socket("user_id", %{user: user.id})
      |> subscribe_and_join(CommentChannel, "comments:#{post.id}")

    {:ok, socket: socket, post: post, comment: comment}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end

  test "CREATED_COMMENT broadcasts to comments:*", %{socket: socket, post: post} do
    push socket, "CREATED_COMMENT", %{"body" => "Test Post", "author" => "Test Author", "postId" => post.id}
    expected = %{"body" => "Test Post", "author" => "Test Author"}
    assert_broadcast "CREATED_COMMENT", expected
  end

  test "APPROVED_COMMENT broadcasts to comments:*", %{socket: socket, post: post, comment: comment} do
    push socket, "APPROVED_COMMENT", %{"commentId" => comment.id, "postId" => post.id, approved: false}
    expected = %{"commentId" => comment.id, "postId" => post.id, approved: true}
    assert_broadcast "APPROVED_COMMENT", expected
  end

  test "DELETED_COMMENT broadcasts to comments:*", %{socket: socket, post: post, comment: comment} do
    payload = %{"commentId" => comment.id, "postId" => post.id}
    push socket, "DELETED_COMMENT", payload
    assert_broadcast "DELETED_COMMENT", payload
  end
end
