defmodule Aiden.Repo.Migrations.CreateAttendances do
  use Ecto.Migration

  def change do
    create table(:attendances, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :fore_noon, :boolean
      add :after_noon, :boolean
      add :date, :date
      add :school_id, references(:schools, on_delete: :nothing, type: :binary_id)
      add :student_id, references(:students, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:attendances, [:student_id])
    create index(:attendances, [:school_id, :date])
  end
end
