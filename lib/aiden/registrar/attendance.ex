defmodule Aiden.Registrar.Attendance do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "attendances" do
    field :after_noon, :boolean
    field :date, :date
    field :fore_noon, :boolean
    belongs_to :school, Aiden.Registrar.School, foreign_key: :school_id
    belongs_to :student, Aiden.Registrar.School, foreign_key: :student_id

    timestamps()
  end

  @doc false
  def changeset(attendance, attrs) do
    attendance
    |> cast(attrs, [:fore_noon, :after_noon, :date, :school_id, :student_id])
    |> validate_required([:fore_noon, :after_noon, :date, :school_id, :student_id])
    |> unique_constraint(:attendances_school_id_student_id_date_index,
      name: :attendances_school_id_student_id_date_index,
      message: "Attendence has already been registered"
    )
  end
end
