defmodule SinetrisBlog.User do
  use Ecto.Model
  import Ecto.Query

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string
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

  def create(username, email, password) do
    username = if is_binary(username), do: String.downcase(username), else: username
    email    = if is_binary(email),    do: String.downcase(email),    else: email
    now      = Ecto.DateTime.from_erl(:calendar.universal_time)
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

  def update(user, email, password) do
    errors = []
    if email do
      user = %{user | email: String.downcase(email)}
      errors = errors ++ validate_email(user)
    end
    if password do
      user = %{user | password: password}
      errors = errors ++ validate_password(user)
      user = %{user | password: gen_password(password)}
    end
    case errors do
      [] ->
        user = %{user | updated_at: Ecto.DateTime.from_erl(:calendar.universal_time)}
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
