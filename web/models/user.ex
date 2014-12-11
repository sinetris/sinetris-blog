defmodule SinetrisBlog.User do
  use Ecto.Model
  import Ecto.Query

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string
    has_many :pages, SinetrisBlog.Page, foreign_key: :author_id
    has_many :menus, SinetrisBlog.Menu, foreign_key: :author_id
    field :created_at, :datetime
    field :updated_at, :datetime
  end

  validate validate_create(user),
    username: present() and has_format(~r"^[a-z0-9_\-\.!~\*'\(\)]+$", message: "illegal characters"),
    also: validate_password,
    also: validate_email

  validatep validate_email(user),
    email: present() and has_format(~r"^[^@]+@[^@]+\.[^@]+$")

  validatep validate_password(user),
    password: present()

  def create(params) do
    username = if is_binary(params[:username]), do: String.downcase(params[:username]), else: params[:username]
    email    = if is_binary(params[:email]),    do: String.downcase(params[:email]),    else: params[:email]
    password = params[:password]
    now      = Ecto.DateTime.utc
    user     = %SinetrisBlog.User{username: username, email: email, password: password,
                                  created_at: now, updated_at: now}
    case validate_create(user) do
      [] ->
        user = %{user | password: gen_password(password)}
        { :ok, Repo.insert(user) }
      errors ->
        { :error, Enum.into(errors, %{}) }
    end
  end

  def update(user, params) do
    errors = []
    email    = if is_binary(params[:email]), do: String.downcase(params[:email]), else: params[:email]
    password = params[:password]
    if email do
      user = %{user | email: String.downcase(email)}
      errors = errors ++ validate_email(user)
    end
    if password && String.length(password) > 0 do
      user = %{user | password: password}
      errors = errors ++ validate_password(user)
      user = %{user | password: gen_password(password)}
    end
    case errors do
      [] ->
        user = %{user | updated_at: Ecto.DateTime.utc}
        Repo.update(user)
        { :ok, user }
      errors ->
        { :error, Enum.into(errors, %{}) }
    end
  end

  def get(nil), do: nil
  def get(username) do
    from(u in SinetrisBlog.User,
         where: downcase(u.username) == downcase(^username),
         limit: 1)
    |> Repo.all
    |> List.first
  end

  def auth?(nil, _password), do: false
  def auth?(user, password) do
    stored_hash   = user.password
    password      = String.to_char_list(password)
    stored_hash   = :erlang.binary_to_list(stored_hash)
    { :ok, hash } = :bcrypt.hashpw(password, stored_hash)
    hash == stored_hash
  end

  defp gen_password(password) do
    password      = String.to_char_list(password)
    work_factor   = 4
    { :ok, salt } = :bcrypt.gen_salt(work_factor)
    { :ok, hash } = :bcrypt.hashpw(password, salt)
    :erlang.list_to_binary(hash)
  end
end
