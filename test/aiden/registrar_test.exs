defmodule Aiden.RegistrarTest do
  use Aiden.DataCase

  alias Aiden.Registrar

  describe "schools" do
    alias Aiden.Registrar.School

    import Aiden.RegistrarFixtures

    @invalid_attrs %{name: nil}

    test "list_schools/0 returns all schools" do
      school = school_fixture()
      assert Registrar.list_schools() == [school]
    end

    test "get_school!/1 returns the school with given id" do
      school = school_fixture()
      assert Registrar.get_school!(school.id) == school
    end

    test "create_school/1 with valid data creates a school" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %School{} = school} = Registrar.create_school(valid_attrs)
      assert school.name == "some name"
    end

    test "create_school/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Registrar.create_school(@invalid_attrs)
    end

    test "update_school/2 with valid data updates the school" do
      school = school_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %School{} = school} = Registrar.update_school(school, update_attrs)
      assert school.name == "some updated name"
    end

    test "update_school/2 with invalid data returns error changeset" do
      school = school_fixture()
      assert {:error, %Ecto.Changeset{}} = Registrar.update_school(school, @invalid_attrs)
      assert school == Registrar.get_school!(school.id)
    end

    test "delete_school/1 deletes the school" do
      school = school_fixture()
      assert {:ok, %School{}} = Registrar.delete_school(school)
      assert_raise Ecto.NoResultsError, fn -> Registrar.get_school!(school.id) end
    end

    test "change_school/1 returns a school changeset" do
      school = school_fixture()
      assert %Ecto.Changeset{} = Registrar.change_school(school)
    end
  end

  describe "students" do
    alias Aiden.Registrar.Student

    import Aiden.RegistrarFixtures

    @invalid_attrs %{name: nil}

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Registrar.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Registrar.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      school = school_fixture()
      valid_attrs = %{name: "some name", school_id: school.id}
      assert {:ok, %Student{} = student} = Registrar.create_student(valid_attrs)
      assert student.name == "some name"
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Registrar.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Student{} = student} = Registrar.update_student(student, update_attrs)
      assert student.name == "some updated name"
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Registrar.update_student(student, @invalid_attrs)
      assert student == Registrar.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Registrar.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Registrar.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Registrar.change_student(student)
    end
  end

  describe "attendances" do
    alias Aiden.Registrar.Attendance

    import Aiden.RegistrarFixtures

    @invalid_attrs %{after_noon: nil, date: nil, fore_noon: nil}

    test "list_attendances/0 returns all attendances" do
      attendance = attendance_fixture()
      assert Registrar.list_attendances() == [attendance]
    end

    test "get_attendance!/1 returns the attendance with given id" do
      attendance = attendance_fixture()
      assert Registrar.get_attendance!(attendance.id) == attendance
    end

    test "create_attendance/1 with valid data creates a attendance" do
      valid_attrs = %{
        after_noon: true,
        date: ~D[2024-03-09],
        fore_noon: true
      }

      student = student_fixture()
      new_attrs = %{name: "some name", school_id: student.school_id, student_id: student.id}
      valid_attrs = Map.merge(valid_attrs, new_attrs)

      assert {:ok, %Attendance{} = attendance} = Registrar.create_attendance(valid_attrs)
      assert attendance.after_noon == true
      assert attendance.date == ~D[2024-03-09]
      assert attendance.fore_noon == true
    end

    test "create_attendance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Registrar.create_attendance(@invalid_attrs)
    end

    test "update_attendance/2 with valid data updates the attendance" do
      attendance = attendance_fixture()

      update_attrs = %{
        after_noon: false,
        date: ~D[2024-03-10],
        fore_noon: false
      }

      assert {:ok, %Attendance{} = attendance} =
               Registrar.update_attendance(attendance, update_attrs)

      assert attendance.after_noon == false
      assert attendance.date == ~D[2024-03-10]
      assert attendance.fore_noon == false
    end

    test "update_attendance/2 with invalid data returns error changeset" do
      attendance = attendance_fixture()
      assert {:error, %Ecto.Changeset{}} = Registrar.update_attendance(attendance, @invalid_attrs)
      assert attendance == Registrar.get_attendance!(attendance.id)
    end

    test "delete_attendance/1 deletes the attendance" do
      attendance = attendance_fixture()
      assert {:ok, %Attendance{}} = Registrar.delete_attendance(attendance)
      assert_raise Ecto.NoResultsError, fn -> Registrar.get_attendance!(attendance.id) end
    end

    test "change_attendance/1 returns a attendance changeset" do
      attendance = attendance_fixture()
      assert %Ecto.Changeset{} = Registrar.change_attendance(attendance)
    end
  end
end
