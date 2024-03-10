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
end
