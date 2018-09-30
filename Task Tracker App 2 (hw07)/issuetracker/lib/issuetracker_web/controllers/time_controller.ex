defmodule IssuetrackerWeb.TimeController do
  use IssuetrackerWeb, :controller

  alias Issuetracker.Tracker
  alias Issuetracker.Tracker.Time

  action_fallback IssuetrackerWeb.FallbackController

  def index(conn, _params) do
    times = Tracker.list_times()
    render(conn, "index.json", times: times)
  end

  def create(conn, %{"time" => time_params}) do
    with {:ok, %Time{} = time} <- Tracker.create_time(time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", time_path(conn, :show, time))
      |> render("show.json", time: time)
    end
  end

  def show(conn, %{"id" => id}) do
    time = Tracker.get_time!(id)
    render(conn, "show.json", time: time)
  end

  def update(conn, %{"id" => id, "time" => time_params}) do
    time = Tracker.get_time!(id)

    with {:ok, %Time{} = time} <- Tracker.update_time(time, time_params) do
      render(conn, "show.json", time: time)
    end
  end

  def delete(conn, %{"id" => id}) do
    time = Tracker.get_time!(id)
    with {:ok, %Time{}} <- Tracker.delete_time(time) do
      send_resp(conn, :no_content, "")
    end
  end
end
