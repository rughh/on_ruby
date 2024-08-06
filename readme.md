# OnRuby

[![donate at patreon](https://img.shields.io/badge/patreon-donate-green.svg)](https://www.patreon.com/on_ruby)
[![build Status](https://github.com/phoet/on_ruby/workflows/build/badge.svg)](https://github.com/phoet/on_ruby/workflows/build/)
[![vulnerability status](https://hakiri.io/github/phoet/on_ruby/master.svg)](https://hakiri.io/github/phoet/on_ruby/master)

[site status & uptime](http://status.onruby.eu/)

[Get in touch in our Slack Channel - join #on_ruby](https://rubyberlin.herokuapp.com/)

Source for the Sites of the Ruby Communities:

* [Hamburg](https://hamburg.onruby.de)
* [Cologne](https://cologne.onruby.de)
* [Berlin](https://www.rug-b.de)
* [Madrid](https://madridrb.onruby.eu)
* [Andalucia](https://andalucia.onruby.eu)

## Support OnRuby

The operation, development and maintenance of OnRuby can be supported via Patreon at [patreon.com/on_ruby](https://www.patreon.com/on_ruby).

### Patrons

* [floriank](https://github.com/floriank)
* [fnordfish](https://github.com/fnordfish)
* [BooVeMan](https://github.com/booveman)
* [rickenharp](https://github.com/rickenharp)
* [ddfreyne](https://github.com/ddfreyne) (Alumni)
* [asaaki](https://github.com/asaaki)
* [5minpause](https://github.com/5minpause)
* [thilo](https://github.com/thilo)
* [rkh](https://github.com/rkh)

## Installation

You can install OnRuby using Docker or a local installation.

### Install using Docker

#### Get containers

Install [Docker and Docker Compose](https://docs.docker.com/compose/install/)
if you haven't already. Then:

```sh
docker-compose up --build
```

> `sudo` might be required for `docker-compose` if you run Docker locally on Linux.

This creates three Docker containers:

- `web` for the application
- `box` for storing rubygems installations
- `db` for the PostgreSQL database

#### Prepare the database

In another terminal, run the Rake task to set up the database structure.

```sh
script/in_docker bundle exec rake db:setup
```

The `script/in_docker` allows you to run commands inside the Docker
container.

*Example*: Running a spec inside the Docker container

```sh
script/in_docker bundle exec rspec spec/requests/labels_spec.rb
```

#### Add usergroup hostnames to `/etc/hosts`

Note: This step is currently only necessary for Safari, all other browsers thread localhost as wildcard domain.

Add all supported subdomains to your `/etc/hosts` file:

```
127.0.0.1    www.onruby.test hamburg.onruby.localhost cologne.onruby.localhost berlin.onruby.localhost madridrb.onruby.localhost andalucia.onruby.localhost
```

#### Visit the site

Navigate to the start page for the OnRuby platform at
[https://www.onruby.test:3000](https://www.onruby.test:3000).

This will list links and logos to all the usergroups.

### Install locally

### On your machine

#### Install PostgreSQL

```sh
# Install PostgreSQL on macOS
brew install postgresql
# or on Ubuntu
sudo apt-get install postgresql postgresql-contrib

# Check if it's running
psql postgres # exit with \q

# Create user and database
createuser -Ps postgres
rake db:setup
```

Use `script/server` to run Rails locally, otherwise you need to export the
environment options yourself:

    bundle --without=production
    script/server

### Add hosts to `/etc/hosts`

For working with the whitelabel functionality, you need to add all supported
subdomains to your `/etc/hosts`:

```
127.0.0.1    www.onruby.test hamburg.onruby.test cologne.onruby.test berlin.onruby.test madridrb.onruby.test andalucia.onruby.test
```

Access via [https://www.onruby.test:3000](https://www.onruby.test:3000)

### Test Data

You don't need any test data to set up a new project!

If you want to have some kind of seed, use this Rake task, to generate some
test data:

    rake data:create

If you are a Heroku project admin, you can dump Data from Heroku via [Taps
Gem](https://devcenter.heroku.com/articles/taps):

    heroku pg:pull HEROKU_POSTGRESQL_MAROON_URL onruby_development

## THE GUIDE TO YOUR RUG

These are the steps to get your Ruby Usergroup Site:

- Fork this repo
- Run `bundle && bundle exec rake fork:usergroup[MyUsergroup]`
- Create a GitHub Pull Request
- *Lean back and wait :)*

If you have a custom domain, you need to [configure the DNS](https://github.com/phoet/on_ruby/issues/360#issuecomment-459729483).

On the admin site we need to:

- `heroku domains:add xyz.onruby.de [custom.de]`
- pull the custom domain into cloudflare
- create a new GitHub app for that domain and add keys via `heroku config:add`
- merge the Pull Request
- deploy to Heroku
- add admin privileges to someone for the new RUG

## Website

![OnRuby Website](https://cl.ly/image/3U0S3b0T0F0x/Screen%20Shot%202014-01-07%20at%2014.16.44.png)

## Admin Interface

The app comes with a [Administrate](https://github.com/thoughtbot/administrate) interface to
manage the model data.

In order to access the admin stuff, you need to be a registered user with the
"admin role".

Typus is mounted under `/admin` of your label, so it's
`https://hamburg.onruby.de/admin` for Hamburg.

### Stuff to manage (CRUD)

- **Users**
- **Events**
    - **Materials**
- **Locations** and **Companies** (Companies are just special Locations)
- **Topics** (Subjects for activities that users can request or propose)
- **Jobs** (These are displayed at top of the page)
- **Highlights** (Special information that you want to display for a short period of time)

## License

"THE (extended) BEER-WARE LICENSE" (Revision 42.0815): [phoet](mailto:ps@nofail.de) contributed to this project.

As long as you retain this notice you can do whatever you want with this stuff.
If we meet some day, and you think this stuff is worth it, you can buy me some beers in return.
