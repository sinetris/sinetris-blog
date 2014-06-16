# Sinetris Blog

To start your new Phoenix application you have to:

1. Install dependencies with `mix deps.get`
2. Start Phoenix router with `mix phoenix.start`

Now you can visit `localhost:4000` from your browser.


### Notes

* If you choose to change the application's structure, you could manually start the router from your code like this `SinetrisBlog.Router.start`

* Do not edit the files in `priv/static/css` or your changes will be lost. You should instead modify the files in `sass/`

To generate the new css files you have to:

1. Install Compass with `bundle install`
2. Compile the CSS with `bundle exec compass compile`

To create an Heroku app:

    heroku apps:create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"
