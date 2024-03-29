defmodule Aiden.Repo.Migrations.CreateSchools do
  use Ecto.Migration

  def change do
    create table(:schools, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end
  end
end
