defmodule Aiden.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      add :school_id, references(:schools, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:students, [:id])
  end
end
