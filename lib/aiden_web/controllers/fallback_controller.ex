defmodule AidenWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use AidenWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: AidenWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # This clause handles errors returned by Skooma
  def call(conn, {:error, error_messages}) when is_list(error_messages) do
    error_messages = List.delete(error_messages, "Your data is all jacked up")

    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ColdstatWeb.ErrorView)
    |> json(%{error: error_messages})
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: AidenWeb.ErrorHTML, json: AidenWeb.ErrorJSON)
    |> render(:"404")
  end
end
