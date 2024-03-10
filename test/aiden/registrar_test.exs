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
end
