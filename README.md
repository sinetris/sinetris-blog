# Sinetris Blog

## Table of contents

 - [Quick start](#quick-start)
 - [Notes](#notes)
 - [Deploy on Heroku](#deploy-on-heroku)
 - [Contributing](#contributing)
 - [Copyright and license](#copyright-and-license)

## Quick start

Install [PostgreSQL](http://www.postgresql.org/download/) and [Elixir](http://elixir-lang.org/), then:

* [Setup the Database](#setup-the-database)
* [Install Dependencies](#install-dependencies)

### Setup the Database

By default SinetrisBlog connect to a localhost postgresql database
named `sinetris_blog_dev` with the username `postgresql` and the password
`postgresql`.

Create this database/user if not already done:

```SQL
CREATE USER postgres;
ALTER USER postgres PASSWORD 'postgres';
```

### Install Dependencies

* Install dependencies with `mix deps.get`
* Create the database with `mix ecto.create Repo`
* Run all migration with `mix ecto.migrate Repo`
* Create a user:

```
~ $ iex -S mix
...
iex(1)> SinetrisBlog.User.create(%{username: "my-username", email: "my-email@example.com", password: "my-password"})

```

* And finally start Phoenix router with `mix phoenix.start`


Now you can visit [http://localhost:4000](http://localhost:4000) from your browser.

## Notes

Do not edit the files in `priv/static/css/styles.css` or your changes will be lost.

You should instead modify the files in `sass/`

To generate the css files you have to:

1. Install `bundler` with `gem install bundler`
2. Install Compass with `bundle install`
3. Compile the CSS with `bundle exec compass compile`

## Tests

You need to [download Selenium](http://docs.seleniumhq.org/download/) and start it:

```
java -jar selenium-server-standalone-2.42.2.jar
```

Fetch the test dependencies using:
```
MIX_ENV=test mix do deps.get
```
and then exec the tests:
```
mix test
```

## Deploy on Heroku

1. Create or configure an [Heroku](https://devcenter.heroku.com/articles/quickstart) app.
2. Set the `SESSION_SECRET`.
3. push the app to Heroku
4. Execute database migrations.
5. Create a user.

To create a new Heroku app, use:
```
heroku apps:create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"
```

To configure an existing Heroku app:
```
heroku config:set BUILDPACK_URL="https://github.com/HashNuke/heroku-buildpack-elixir.git"
```

Set the `MIX_ENV` to prod:
```
heroku config:set MIX_ENV=prod
```

Set the `SESSION_SECRET`:
```
heroku config:set SESSION_SECRET="must be at least 64 characters long"
```

Push to Heroku:
```
git push heroku master
```

Migrate:
```
heroku run mix ecto.migrate Repo
```

Create a user:
```
~ $ heroku run bash
Running `bash` attached to terminal...
~ $ iex -S mix
...
iex(1)> SinetrisBlog.User.create(%{username: "my-username", email: "my-email@example.com", password: "my-password"})

```

## Contributing

1. [Fork](https://help.github.com/articles/fork-a-repo) this repo
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a [Pull Request](http://help.github.com/pull-requests/) from your
   branch
5. That's it!

## Copyright and license

Copyright (c) 2014 Duilio Ruggiero. Code released under [the MIT license](LICENSE).
