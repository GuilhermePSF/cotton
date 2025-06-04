defmodule CottonWeb.ProjController do
  use CottonWeb, :controller

  def proj(conn, _params) do
    render(conn, :proj)
  end

  def show(conn, %{"messenger" => messenger}) do
    render(conn, :show, messenger: messenger)
  end

end
