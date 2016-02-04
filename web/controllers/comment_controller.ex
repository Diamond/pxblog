defmodule Pxblog.CommentController do
  use Pxblog.Web, :controller

  alias Pxblog.Comment
  alias Pxblog.Post

  plug :scrub_params, "comment" when action in [:create, :update]

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

  def update(conn, _), do: conn
  def delete(conn, _), do: conn

end


  #alias Pxblog.Comment
  #alias Pxblog.Post

  #plug :assign_post
  #plug :authorize_user when action in [:delete]


  #def delete(conn, %{"id" => id}) do
    #comment = Repo.get!(Comment, id)
    #Repo.delete!(comment)
    #conn
    #|> put_flash(:info, "Comment deleted successfully.")
    #|> redirect(to: user_post_path(conn, :index, conn.assigns[:post].user, conn.assigns[:post]))
  #end

  #defp assign_post(conn, _opts) do
    #case conn.params do
      #%{"post_id" => post_id} ->
        #post = Repo.get(Post, post_id) |> Repo.preload(:user)
        #case post do
          #nil  -> invalid_post(conn)
          #post -> assign(conn, :post, post)
        #end
      #_ ->
        #invalid_post(conn)
    #end
  #end

  #defp invalid_post(conn) do
    #conn
    #|> put_flash(:error, "Invalid post!")
    #|> redirect(to: page_path(conn, :index))
    #|> halt
  #end

  #defp authorize_user(conn, _opts) do
    #user = get_session(conn, :current_user)
    #post = conn.assigns[:post]
    #if user && Pxblog.RoleChecker.is_admin?(user) do
      #conn
    #else
      #conn
      #|> put_flash(:error, "You are not authorized to modify that post!")
      #|> redirect(to: page_path(conn, :index))
      #|> halt
    #end
  #end
  #end
