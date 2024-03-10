defmodule AidenWeb.AttendanceJSON do
  alias Aiden.Registrar.Attendance

  @doc """
  Renders a list of attendances.
  """
  def index(%{attendances: attendances}) do
    %{data: for(attendance <- attendances, do: data(attendance))}
  end

  @doc """
  Renders a single attendance.
  """
  def show(%{attendance: attendance}) do
    %{data: data(attendance)}
  end

  defp data(%Attendance{} = attendance) do
    %{
      id: attendance.id,
      fore_noon: attendance.fore_noon,
      after_noon: attendance.after_noon,
      date: attendance.date
    }
  end
end
