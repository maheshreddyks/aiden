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
end
