defmodule AidenWeb.SchoolController do
  use AidenWeb, :controller

  alias Aiden.Registrar
  alias Aiden.Registrar.School

  action_fallback AidenWeb.FallbackController

  def index(conn, _params) do
    schools = Registrar.list_schools()
    render(conn, :index, schools: schools)
  end

  def create(conn, %{"school" => school_params}) do
    with {:ok, %School{} = school} <- Registrar.create_school(school_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/schools/#{school}")
      |> render(:show, school: school)
    end
  end

  def show(conn, %{"id" => id}) do
    school = Registrar.get_school!(id)
    render(conn, :show, school: school)
  end

  def update(conn, %{"id" => id, "school" => school_params}) do
    school = Registrar.get_school!(id)

    with {:ok, %School{} = school} <- Registrar.update_school(school, school_params) do
      render(conn, :show, school: school)
    end
  end

  def delete(conn, %{"id" => id}) do
    school = Registrar.get_school!(id)

    with {:ok, %School{}} <- Registrar.delete_school(school) do
      send_resp(conn, :no_content, "")
    end
  end
end
