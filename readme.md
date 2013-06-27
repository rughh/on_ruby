# OnRuby
[![Build Status](https://secure.travis-ci.org/phoet/on_ruby.png)](https://travis-ci.org/phoet/on_ruby)
[![Code Climate](https://codeclimate.com/github/phoet/on_ruby.png)](https://codeclimate.com/github/phoet/on_ruby)
[![Coverage Status](https://coveralls.io/repos/phoet/on_ruby/badge.png?branch=master)](https://coveralls.io/r/phoet/on_ruby?branch=master)


Source for the Sites of the Ruby Communities [Hamburg](http://hamburg.onruby.de), [Bremen](http://bremen.onruby.de), [Cologne](http://cologne.onruby.de), [Saarland](http://saar.onruby.de), [Berlin](http://berlin.onruby.de), [Leipzig](http://leipzig.onruby.de), [Karlsruhe](http://karlsruhe.onruby.de), [Dresden](http://dresden.onruby.de)

## Setup

Use *foreman* to start the server, otherwise you need to export the options of the *.env* file manually:

    bundle --without=production
    rake db:setup
    foreman start

### Hosts

For working with the whitelabel functionality, you need to add all supported subdomains to your */etc/hosts* :

    127.0.0.1    www.onruby.dev hamburg.onruby.dev cologne.onruby.dev bremen.onruby.dev saar.onruby.dev berlin.onruby.dev karlsruhe.onruby.dev leipzig.onruby.dev dresden.onruby.dev

Access via [http://www.onruby.dev:5000](http://www.onruby.dev:5000)

### Test-Data

You don't need any to setup a new project!

If you want to have some kind of seed, than generate some test-data:

    rake data:create

If you are a heroku project admin, you can dump Data from Heroku via [Taps Gem](https://devcenter.heroku.com/articles/taps):

    heroku db:pull

## THE GUIDE TO YOUR RUG

There are just a couple of steps for your Ruby Usergroup Site to get alive:

- fork this repo
- create a new branch
- provide mandatory changes to the following files:
    - config/whitelabel.yml
    - config/locales/*.label.yml
    - app/assets/images/labels/your_label.png
- add optional custom files to:
    - app/assets/images/labels
    - app/assets/stylesheets/labels
    - app/assets/javascripts/labels
- create pull request
- *lean back and wait :)*

If you have a custom domain, you need to setup the [CNAME of your domain to point to heroku](https://devcenter.heroku.com/articles/custom-domains#dns_setup).

On the admin-site we need to:

- heroku domains:add xyz.onruby.de [custom.de]
- merge the pull
- deploy to heroku
- add admin privileges to someone for the new RUG

## Website

![OnRuby Website](http://f.cl.ly/items/3o0v3c2d1X3A0o3s0O11/Bildschirmfoto%202012-09-26%20um%2019.23.17.png)

## Mobile Website

![OnRuby Mobile](http://f.cl.ly/items/02203G1m3Y3X3p1O153g/mobile.png)

## Admin Interface

The app comes with an [ActiveAdmin](https://github.com/gregbell/active_admin) interface to manage the model data.
In order to access the admin stuff, you need to be a registered user with the "admin role".
ActiveAdmin is mounted under */admin* of your label, so it's *hamburg.onruby.de/admin* for Hamburg.

### Stuff to manage (CRUD)

- Users
- Events
    - Materials
- Locations / Companies (Companies are just special Locations)
- Topics (Stuff that user can demand/propose)
- Jobs (The Display on top of the Page)
- Highlights (Special infos, that you want to display for a short period of time)

## License

"THE BEER-WARE LICENSE" (Revision 42):
[ps@nofail.de](mailto:ps@nofail.de) wrote this file. As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return Peter Schröder
