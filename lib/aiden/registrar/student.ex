defmodule Aiden.Registrar.Student do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "students" do
    field :name, :string

    belongs_to :school, Aiden.Registrar.School, foreign_key: :school_id

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name, :school_id])
    |> validate_required([:name, :school_id])
  end
end
