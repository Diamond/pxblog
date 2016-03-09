defmodule Pxblog.CommentControllerTest do
  use Pxblog.ConnCase

  alias Pxblog.Comment
  alias Pxblog.Factory

  @valid_attrs %{author: "Some Person", body: "This is a sample comment"}
  @invalid_attrs %{}

  setup do
    user    = Factory.create(:user)
    post    = Factory.create(:post, user: user)
    comment = Factory.create(:comment, post: post)

    {:ok, conn: conn, user: user, post: post, comment: comment}
  end

  defp login_user(conn, user) do
    post conn, session_path(conn, :create), user: %{username: user.username, password: user.password}
  end

  test "creates resource and redirects when data is valid", %{conn: conn, post: post} do
    conn = post conn, post_comment_path(conn, :create, post), comment: @valid_attrs
    assert redirected_to(conn) == user_post_path(conn, :show, post.user, post)
    assert Repo.get_by(assoc(post, :comments), @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, post: post} do
    conn = post conn, post_comment_path(conn, :create, post), comment: @invalid_attrs
    assert html_response(conn, 200) =~ "Oops, something went wrong"
  end

  test "deletes the comment when logged in as an authorized user", %{conn: conn, user: user, post: post, comment: comment} do
    conn = login_user(conn, user) |> delete(post_comment_path(conn, :delete, post, comment))
    assert redirected_to(conn) == user_post_path(conn, :show, post.user, post)
    refute Repo.get(Comment, comment.id)
  end

  test "does not delete the comment when not logged in as an authorized user", %{conn: conn, post: post, comment: comment} do
    conn = delete(conn, post_comment_path(conn, :delete, post, comment))
    assert redirected_to(conn) == page_path(conn, :index)
    assert Repo.get(Comment, comment.id)
  end

  test "updates chosen resource and redirects when data is valid and logged in as the author", %{conn: conn, user: user, post: post, comment: comment} do
    conn = login_user(conn, user) |> put(post_comment_path(conn, :update, post, comment), comment: %{"approved" => true})
    assert redirected_to(conn) == user_post_path(conn, :show, user, post)
    assert Repo.get_by(Comment, %{id: comment.id, approved: true})
  end

  test "does not update the comment when not logged in as an authorized user", %{conn: conn, post: post, comment: comment} do
    conn = put(conn, post_comment_path(conn, :update, post, comment), comment: %{"approved" => true})
    assert redirected_to(conn) == page_path(conn, :index)
    refute Repo.get_by(Comment, %{id: comment.id, approved: true})
  end
end
