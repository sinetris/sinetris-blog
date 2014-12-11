defmodule SinetrisBlog.MenuItem do
  use Ecto.Model
  import Ecto.Query

  schema "menu_items" do
    belongs_to :menu, SinetrisBlog.Menu
    field :title, :string
    field :url, :string
    field :position, :integer
    field :created_at, :datetime
    field :updated_at, :datetime
  end

  validate validate_all(menu_item),
    menu: present(),
    title: present(),
    url: present()

  def create(nil, params) do
    { :error, %{menu: "can't be blank"} }
  end

  def create(menu, params) do
    title    = params[:title]
    url      = params[:url]
    position = params[:position]
    now      = Ecto.DateTime.utc
    menu_item = struct(menu.menu_items, title: title, url: url,
                      position: position, created_at: now, updated_at: now)
    case validate_all(menu_item) do
      [] ->
        { :ok, Repo.insert(menu_item) }
      errors ->
        { :error, Enum.into(errors, %{}) }
    end
  end

  def update(menu_item, params) do
    errors = []
    title = params[:title] || menu_item.title
    url = params[:url] || menu_item.url
    position = params[:position] || menu_item.position
    menu_item = %{menu_item | title: title, url: url, position: position}
    errors = errors ++ validate_all(menu_item)
    case errors do
      [] ->
        menu_item = %{menu_item | updated_at: Ecto.DateTime.utc}
        Repo.update(menu_item)
        { :ok, menu_item }
      errors ->
        { :error, Enum.into(errors, %{}) }
    end
  end

  def get(nil), do: nil
  def get(id) do
    from(m in SinetrisBlog.MenuItem,
         where: m.id == ^id,
         limit: 1, preload: [:menu])
    |> Repo.all
    |> List.first
  end

  def get_menu(menu_id) do
    from(u in SinetrisBlog.MenuItem,
        where: u.menu_id == ^menu_id,
        order_by: [asc: u.position])
    |> Repo.all
  end
end
