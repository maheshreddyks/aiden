defmodule Aiden.RegistrarFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Aiden.Registrar` context.
  """

  @doc """
  Generate a school.
  """
  def school_fixture(attrs \\ %{}) do
    {:ok, school} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Aiden.Registrar.create_school()

    school
  end

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    school = school_fixture()

    {:ok, student} =
      attrs
      |> Enum.into(%{
        name: "some name",
        school_id: school.id
      })
      |> Aiden.Registrar.create_student()

    student
  end

  @doc """
  Generate a attendance.
  """
  def attendance_fixture(attrs \\ %{}) do
    student = student_fixture()

    {:ok, attendance} =
      attrs
      |> Enum.into(%{
        after_noon: true,
        date: ~D[2024-03-09],
        fore_noon: true,
        student_id: student.id,
        school_id: student.school_id
      })
      |> Aiden.Registrar.create_attendance()

    attendance
  end
end
