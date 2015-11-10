defmodule Pxblog.PostView do
  use Pxblog.Web, :view

  def markdown(body) do
    body
    |> Earmark.to_html
    |> raw
  end
end
