defmodule LiveViewTodo.Item do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias LiveViewTodo.Repo
  alias __MODULE__

  schema "items" do
    field :person_id, :integer
    field :status, :integer, default: 0
    field :text, :string

    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:text, :person_id, :status])
    |> validate_required([:text])
  end

  def create_item(attrs \\ %{}) do
    %Item{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def get_item!(id), do: Repo.get!(Item, id)

  def list_items do
    Item
    |> order_by(desc: :inserted_at)
    |> where([a], is_nil(a.status) or a.status != 2)
    |> Repo.all()
  end

  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  def delete_item(id) do
    get_item!(id)
    |> Item.changeset(%{status: 2})
    |> Repo.update()
  end

  def clear_completed() do
    completed_items = from(i in Item, where: i.status == 1)
    Repo.update_all(completed_items, set: [status: 2])
  end
end
