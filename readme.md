# OnRuby
[![Build Status](https://img.shields.io/travis/phoet/on_ruby/master.svg)](https://travis-ci.org/phoet/on_ruby)
[![Code Climate](https://img.shields.io/codeclimate/github/phoet/on_ruby.svg)](https://codeclimate.com/github/phoet/on_ruby)
[![Coverage Status](http://img.shields.io/codeclimate/coverage/github/phoet/on_ruby.svg)](https://codeclimate.com/github/phoet/on_ruby)

Source for the Sites of the Ruby Communities

* [Hamburg](http://hamburg.onruby.de)
* [Bremen](http://bremen.onruby.de)
* [Cologne](http://cologne.onruby.de)
* [Saarland](http://saar.onruby.de)
* [Berlin](http://www.rug-b.de)
* [Leipzig](http://leipzig.onruby.de)
* [Karlsruhe](http://karlsruhe.onruby.de)
* [Dresden](http://dresden.onruby.de)
* [Railsgirls Hamburg](http://railsgirlshh.onruby.de)
* [Bonn](http://bonn.onruby.de)
* [Innsbruck](http://innsbruck.onruby.at)
* [Madrid](http://madridrb.onruby.eu)

[![I Love Open Source](http://www.iloveopensource.io/images/logo-lightbg.png)](http://www.iloveopensource.io/projects/524c41bdca7964c61700044d)

## Status

[![Up-time](https://share.pingdom.com/banners/9a5fa346)](http://stats.pingdom.com/rt22wr280x9j/616285)
[![Response-time](https://share.pingdom.com/banners/eb9be8df)](http://stats.pingdom.com/rt22wr280x9j/616285)

## Setup

### Postgresql

```sh
# install Postgres on Mac OS X
brew install postgresql
# or on Ubuntu
sudo apt-get install postgresql postgresql-contrib

# check if it's running
psql postgres # exit with \q

# create user and database
createuser -Ps postgres
rake db:setup
```

Use `script/server` to run rails locally, otherwise you need to export the environment options yourself:

    bundle --without=production
    script/server

### Hosts

For working with the whitelabel functionality, you need to add all supported subdomains to your */etc/hosts* :

    127.0.0.1    www.onruby.dev hamburg.onruby.dev cologne.onruby.dev bremen.onruby.dev saar.onruby.dev
    127.0.0.1    berlin.onruby.dev karlsruhe.onruby.dev leipzig.onruby.dev dresden.onruby.dev
    127.0.0.1    railsgirlshh.onruby.dev bonn.onruby.dev madridrb.onruby.dev

Access via [http://www.onruby.dev:5000](http://www.onruby.dev:5000)

### Test-Data

You don't need any to setup a new project!

If you want to have some kind of seed, than generate some test-data:

    rake data:create

If you are a heroku project admin, you can dump Data from Heroku via [Taps Gem](https://devcenter.heroku.com/articles/taps):

    heroku pg:pull HEROKU_POSTGRESQL_MAROON_URL onruby_development

## THE GUIDE TO YOUR RUG

There are just a couple of steps for your Ruby Usergroup Site to get alive:

- fork this repo
- run `bundle && bundle exec rake fork:usergroup[MyUsergroup]`
- create pull request
- *lean back and wait :)*

If you have a custom domain, you need to setup the [CNAME of your domain to point to heroku](https://devcenter.heroku.com/articles/custom-domains#dns_setup).

On the admin-site we need to:

- heroku domains:add xyz.onruby.de [custom.de]
- create new GitHub app for that domain and add keys via heroku config:add
- merge the pull
- deploy to heroku
- add admin privileges to someone for the new RUG

## Website

![OnRuby Website](http://cl.ly/image/3U0S3b0T0F0x/Screen%20Shot%202014-01-07%20at%2014.16.44.png)

## Admin Interface

The app comes with an [Typus](https://github.com/fesplugas/typus) interface to manage the model data.
In order to access the admin stuff, you need to be a registered user with the "admin role".
Typus is mounted under */admin* of your label, so it's *http://hamburg.onruby.de/admin* for Hamburg.

### Stuff to manage (CRUD)

- Users
- Events
    - Materials
- Locations / Companies (Companies are just special Locations)
- Topics (Stuff that user can demand/propose)
- Jobs (The Display on top of the Page)
- Highlights (Special infos, that you want to display for a short period of time)

## License

"THE (extended) BEER-WARE LICENSE" (Revision 42.0815): [phoet](mailto:ps@nofail.de) contributed to this project.

As long as you retain this notice you can do whatever you want with this stuff.
If we meet some day, and you think this stuff is worth it, you can buy me some beers in return.
