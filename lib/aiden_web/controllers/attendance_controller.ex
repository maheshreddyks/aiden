defmodule AidenWeb.AttendanceController do
  use AidenWeb, :controller

  alias Aiden.Registrar
  alias Aiden.Registrar.Attendance

  action_fallback AidenWeb.FallbackController

  def index(conn, _params) do
    attendances = Registrar.list_attendances()
    render(conn, :index, attendances: attendances)
  end

  def attendance_query(conn, params) do
    attendances = Registrar.list_attendances_query(params)
    render(conn, :index, attendances: attendances)
  end

  def create(conn, %{"attendance" => attendance_params}) do
    with {:ok, %Attendance{} = attendance} <- Registrar.create_attendance(attendance_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/attendances/#{attendance}")
      |> render(:show, attendance: attendance)
    end
  end

  def show(conn, %{"id" => id}) do
    attendance = Registrar.get_attendance!(id)
    render(conn, :show, attendance: attendance)
  end

  def update(conn, %{"id" => id, "attendance" => attendance_params}) do
    attendance = Registrar.get_attendance!(id)

    with {:ok, %Attendance{} = attendance} <-
           Registrar.update_attendance(attendance, attendance_params) do
      render(conn, :show, attendance: attendance)
    end
  end

  def delete(conn, %{"id" => id}) do
    attendance = Registrar.get_attendance!(id)

    with {:ok, %Attendance{}} <- Registrar.delete_attendance(attendance) do
      send_resp(conn, :no_content, "")
    end
  end

  def create_attendance(conn, %{"attendance" => attendance_params}) do
    with :ok <- Aiden.Utils.skooma_validator(attendance_params, attendance_schema()),
         {:ok, %Attendance{} = attendance} <-
           Registrar.create_attendances(attendance_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/attendances/#{attendance}")
      |> render(:show, attendance: attendance)
    end
  end

  ## Private Fns
  defp attendance_schema() do
    %{
      :attendance_status => :bool,
      :attendance_type => [:string, Aiden.Utils.validate_enum(["fore_noon", "after_noon"])],
      :school_id => [:string, Aiden.Utils.is_uuid()],
      :student_id => [:string, Aiden.Utils.is_uuid()]
    }
  end
end
