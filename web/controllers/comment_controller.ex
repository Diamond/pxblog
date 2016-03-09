defmodule Pxblog.CommentController do
  use Pxblog.Web, :controller

  alias Pxblog.Comment
  alias Pxblog.Post

  plug :scrub_params, "comment" when action in [:create, :update]
  plug :set_post_and_authorize_user when action in [:update, :delete]

  def create(conn, %{"comment" => comment_params, "post_id" => post_id}) do
    post      = Repo.get!(Post, post_id) |> Repo.preload([:user, :comments])
    changeset = post
      |> build_assoc(:comments)
      |> Comment.changeset(comment_params)

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully!")
        |> redirect(to: user_post_path(conn, :show, post.user, post))
      {:error, changeset} ->
        render(conn, Pxblog.PostView, "show.html", post: post, user: post.user, comment_changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    post = conn.assigns[:post]
    comment = Repo.get!(Comment, id)
    changeset = Comment.changeset(comment, comment_params)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        |> redirect(to: user_post_path(conn, :show, post.user, post))
      {:error, _} ->
        conn
        |> put_flash(:error, "Failed to update comment!")
        |> redirect(to: user_post_path(conn, :show, post.user, post))
    end
  end

  def delete(conn, %{"id" => id}) do
    post = conn.assigns[:post]
    comment = Repo.get!(Comment, id)
    Repo.delete!(comment)
    conn
    |> put_flash(:info, "Deleted comment!")
    |> redirect(to: user_post_path(conn, :show, post.user, post))
  end

  defp set_post(conn) do
    post = Repo.get!(Post, conn.params["post_id"]) |> Repo.preload(:user)
    assign(conn, :post, post)
  end

  defp set_post_and_authorize_user(conn, _opts) do
    conn = set_post(conn)
    if is_authorized_user?(conn) do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized to modify that comment!")
      |> redirect(to: page_path(conn, :index))
      |> halt
    end
  end

  defp is_authorized_user?(conn) do
    user = get_session(conn, :current_user)
    post = conn.assigns[:post]
    (user && (user.id == post.user_id || Pxblog.RoleChecker.is_admin?(user)))
  end
end
