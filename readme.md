# OnRuby
![Status](https://secure.travis-ci.org/phoet/on_ruby.png "Status")

Source for the Sites of the Ruby Communities

- [Hamburg](http://hamburg.onruby.de)
- [Bremen](http://bremen.onruby.de)
- [Cologne](http://cologne.onruby.de)
- [Saarland](http://saar.onruby.de)
- [München](http://munich.onruby.de)
- [Karlsruhe](http://karlsruhe.onruby.de)

![OnRuby](http://f.cl.ly/items/0Z1V0M0f3V1C390R0L0s/Bildschirmfoto%202012-07-23%20um%2023.13.12.png)

## Setup

Use *foreman* to start the server, otherwise you need to export the options of the *.env* file manually:

    bundle --without=production
    foreman start

### Hosts

For working with the whitelabel functionality, you need to add all supported subdomains to your */etc/hosts* :

    127.0.0.1    onruby.dev hamburg.onruby.dev cologne.onruby.dev bremen.onruby.dev saar.onruby.dev munich.onruby.dev karlsruhe.onruby.dev

Access via [http://onruby.dev:5000](http://onruby.dev:5000)

### Twitter-Authentication

You need [Twitter App credentials](https://dev.twitter.com) in order to have a working login.

See *config/initializers/omniauth.rb* for details.

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

If you have a custom domain, you need to setup the CNAME of your domain to point to [heroku](https://devcenter.heroku.com/articles/custom-domains#dns_setup).

On the admin-site we need to:

- heroku domains:add xyz.onruby.de [custom.de]
- merge the pull
- deploy to heroku
- add admin privileges to someone for the new RUG

## Admin Interface

The app comes with an [ActiveAdmin](https://github.com/gregbell/active_admin) interface to manage the model data.
In order to access the admin stuff, you need to be a registered user with the "admin role".
ActiveAdmin is mounted under */admin* of your label, so it's *hamburg.onruby.de/admin* for Hamburg.

### Stuff to manage (CRUD)

- Users
- Events
    - Materials
    - Topics
- Locations / Companies (Companies are just special Locations)
- Wishes (Stuff that user can demand/propose)
- Jobs (The Display on top of the Page)
- Highlights (Special infos, that you want to display for a short period of time)

![ActiveAdmin](http://f.cl.ly/items/2w3P211I0a032u2x1k3k/Bildschirmfoto%202012-07-23%20um%2023.09.59.png)

## License

"THE BEER-WARE LICENSE" (Revision 42):
[ps@nofail.de](mailto:ps@nofail.de) wrote this file. As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return Peter Schröder
