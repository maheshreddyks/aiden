defmodule AidenWeb.StudentController do
  use AidenWeb, :controller

  alias Aiden.Registrar
  alias Aiden.Registrar.Student

  action_fallback AidenWeb.FallbackController

  def index(conn, params) do
    students = Registrar.list_students_by_school(params["school_id"])
    render(conn, :index, students: students)
  end

  def create(conn, %{"student" => student_params}) do
    with {:ok, %Student{} = student} <- Registrar.create_student(student_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/students/#{student}")
      |> render(:show, student: student)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Registrar.get_student!(id)
    render(conn, :show, student: student)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Registrar.get_student!(id)

    with {:ok, %Student{} = student} <- Registrar.update_student(student, student_params) do
      render(conn, :show, student: student)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Registrar.get_student!(id)

    with {:ok, %Student{}} <- Registrar.delete_student(student) do
      send_resp(conn, :no_content, "")
    end
  end
end
