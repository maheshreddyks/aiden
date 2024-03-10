defmodule Aiden.Repo do
  use Ecto.Repo,
    otp_app: :aiden,
    adapter: Ecto.Adapters.Postgres
end
