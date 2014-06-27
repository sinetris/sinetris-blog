defmodule SinetrisBlog.Page do
  use Ecto.Model
  import Ecto.Query

  schema "pages" do
    belongs_to :author, SinetrisBlog.User
    field :slug, :string
    field :title, :string
    field :body, :string
    field :created_at, :datetime
    field :updated_at, :datetime
  end

  validate validate_all(page),
    also: validate_title,
    also: validate_body,
    also: validate_slug

  # TODO: validate uniqueness of slug
  validatep validate_slug(page),
    slug: has_format(~r"^[a-z0-9\-]+$", message: "illegal characters"),
    slug: present()

  validatep validate_title(page),
    title: present()

  validatep validate_body(page),
    body: present()

  def create(author, slug, title, body) do
    slug     = if is_binary(slug), do: String.downcase(slug), else: slug
    now      = Ecto.DateTime.from_erl(:calendar.universal_time)
    page     = struct(author.pages, slug: sanitize_slug(slug), title: title,
                      body: body, created_at: now, updated_at: now)
    case validate_all(page) do
      [] ->
        { :ok, Repo.insert(page) }
      errors ->
        { :error, Enum.into(errors, %{}) }
    end
  end

  def update(page, slug, title, body) do
    errors = []
    page = %{page | slug: sanitize_slug(slug), title: title, body: body}
    errors = errors ++ validate_all(page)
    case errors do
      [] ->
        page = %{page | updated_at: Ecto.DateTime.from_erl(:calendar.universal_time)}
        Repo.update(page)
        { :ok, page }
      errors ->
        { :error, Enum.into(errors, %{}) }
    end
  end

  def get(nil), do: nil
  def get(slug) do
    from(u in SinetrisBlog.Page,
         where: downcase(u.slug) == downcase(^slug),
         limit: 1, preload: [:author])
    |> Repo.all
    |> List.first
  end

  def all() do
    from(u in SinetrisBlog.Page, preload: [:author])
    |> Repo.all
  end
  
  defp sanitize_slug(slug) do
    String.downcase(slug)
  end
end
