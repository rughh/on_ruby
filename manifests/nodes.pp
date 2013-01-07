# http://feross.org/how-to-setup-your-linode/
# http://phaseshiftllc.com/articles/2012/03/19/setting-up-vagrant-with-rvm-and-mysql-for-rails-development.html
node "onruby" {
  include base
  include heroku
  include capistrano
  include apache2
  include passenger
  include memcache
  include mysql
  include sendmail
}
