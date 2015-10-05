defmodule Pxblog.PageController do
  use Pxblog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
