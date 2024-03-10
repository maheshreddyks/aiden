defmodule AidenWeb.StudentControllerTest do
  use AidenWeb.ConnCase

  import Aiden.RegistrarFixtures

  alias Aiden.Registrar.Student

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{id: nil, name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create student" do
    test "renders student when data is valid", %{conn: conn} do
      school = school_fixture()
      create_attrs = Map.merge(@create_attrs, %{school_id: school.id})
      conn = post(conn, ~p"/api/students", student: create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/students/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/students", student: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update student" do
    setup [:create_student]

    test "renders student when data is valid", %{conn: conn, student: %Student{id: id} = student} do
      conn = put(conn, ~p"/api/students/#{student}", student: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/students/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, student: student} do
      conn = put(conn, ~p"/api/students/#{student}", student: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete student" do
    setup [:create_student]

    test "deletes chosen student", %{conn: conn, student: student} do
      conn = delete(conn, ~p"/api/students/#{student}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/students/#{student}")
      end
    end
  end

  defp create_student(_) do
    student = student_fixture()
    %{student: student}
  end
end
