defmodule Aiden.Utils do
  @moduledoc """
  All the helper functions
  """

  def is_uuid() do
    fn string ->
      case UUID.info(string) do
        {:ok, _string} ->
          :ok

        {:error, _error} ->
          {:error, "Send a Valid UUID"}
      end
    end
  end

  def validate_enum(list) do
    fn data ->
      if data in list do
        :ok
      else
        {:error, "Send only #{Enum.join(list, ",")} in operation"}
      end
    end
  end

  def skooma_validator(params, schema) do
    params
    |> Jason.encode!()
    |> Jason.decode!(keys: :atoms)
    |> Skooma.valid?(schema)
  end
end
