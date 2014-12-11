defmodule SinetrisBlog.Menu do
  use Ecto.Model
  import Ecto.Query

  schema "menus" do
    belongs_to :author, SinetrisBlog.User
    field :title, :string
    field :created_at, :datetime
    field :updated_at, :datetime
  end

  validate validate_all(menu),
    author: present(),
    title:  present()

  def create(nil, params) do
    { :error, %{author: "can't be blank"} }
  end

  def create(author, params) do
    title    = params[:title]
    now      = Ecto.DateTime.utc
    menu     = struct(author.menus, title: title,
                      created_at: now, updated_at: now)
    case validate_all(menu) do
      [] ->
        { :ok, Repo.insert(menu) }
      errors ->
        { :error, Enum.into(errors, %{}) }
    end
  end

  def update(menu, params) do
    errors = []
    title = params[:title] || menu.title
    menu = %{menu | title: title}
    errors = errors ++ validate_all(menu)
    case errors do
      [] ->
        menu = %{menu | updated_at: Ecto.DateTime.utc}
        Repo.update(menu)
        { :ok, menu }
      errors ->
        { :error, Enum.into(errors, %{}) }
    end
  end

  def get(nil), do: nil
  def get(id) do
    from(m in SinetrisBlog.Menu,
         where: m.id == ^id,
         limit: 1, preload: [:author])
    |> Repo.all
    |> List.first
  end

  def all() do
    from(u in SinetrisBlog.Menu, preload: [:author])
    |> Repo.all
  end
end
