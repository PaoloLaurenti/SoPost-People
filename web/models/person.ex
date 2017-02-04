defmodule SopostPeople.Person do
  use SopostPeople.Web, :model

  schema "people" do
    field :name, :string
    field :role, :string
    field :location, :string
    field :photo, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :role, :location, :photo])
    #|> validate_required([:name, :role, :location, :photo])
  end
end
