defmodule AidenWeb.AttendanceControllerTest do
  use AidenWeb.ConnCase

  import Aiden.RegistrarFixtures

  alias Aiden.Registrar.Attendance

  @create_attrs %{
    after_noon: true,
    date: ~D[2024-03-09],
    fore_noon: true
  }
  @update_attrs %{
    after_noon: false,
    date: ~D[2024-03-10],
    fore_noon: false
  }
  @invalid_attrs %{after_noon: nil, date: nil, fore_noon: nil, id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all attendances", %{conn: conn} do
      conn = get(conn, ~p"/api/attendances")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create attendance" do
    test "renders attendance when data is valid", %{conn: conn} do
      student = student_fixture()

      create_attrs =
        Map.merge(@create_attrs, %{school_id: student.school_id, student_id: student.id})

      conn = post(conn, ~p"/api/attendances", attendance: create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/attendances/#{id}")

      assert %{
               "id" => ^id,
               "after_noon" => true,
               "date" => "2024-03-09",
               "fore_noon" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/attendances", attendance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update attendance" do
    setup [:create_attendance]

    test "renders attendance when data is valid", %{
      conn: conn,
      attendance: %Attendance{id: id} = attendance
    } do
      conn = put(conn, ~p"/api/attendances/#{attendance}", attendance: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/attendances/#{id}")

      assert %{
               "id" => ^id,
               "after_noon" => false,
               "date" => "2024-03-10",
               "fore_noon" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, attendance: attendance} do
      conn = put(conn, ~p"/api/attendances/#{attendance}", attendance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete attendance" do
    setup [:create_attendance]

    test "deletes chosen attendance", %{conn: conn, attendance: attendance} do
      conn = delete(conn, ~p"/api/attendances/#{attendance}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/attendances/#{attendance}")
      end
    end
  end

  defp create_attendance(_) do
    attendance = attendance_fixture()
    %{attendance: attendance}
  end
end
