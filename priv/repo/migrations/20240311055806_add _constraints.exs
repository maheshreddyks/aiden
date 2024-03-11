defmodule :"Elixir.Aiden.Repo.Migrations.Add Constraints" do
  use Ecto.Migration

  def change do
    create unique_index(:attendances, [:school_id, :student_id, :date])
    create unique_index(:students, [:id, :school_id])
  end
end
