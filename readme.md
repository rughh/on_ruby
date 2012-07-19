# OnRuby
![Status](https://secure.travis-ci.org/phoet/on_ruby.png "Status")

Source for the Sites of the Ruby Communities

* [Hamburg](http://hamburg.onruby.de)
* [Bremen](http://bremen.onruby.de)
* [Cologne](http://cologne.onruby.de)
* [Saarland](http://saar.onruby.de)
* [München](http://munich.onruby.de)
* [Karlsruhe](http://karlsruhe.onruby.de)

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

## Todo

- add rack-cache
- publishing via xing

## License

"THE BEER-WARE LICENSE" (Revision 42):
[ps@nofail.de](mailto:ps@nofail.de) wrote this file. As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return Peter Schröder
