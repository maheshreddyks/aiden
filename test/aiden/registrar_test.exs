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
end
