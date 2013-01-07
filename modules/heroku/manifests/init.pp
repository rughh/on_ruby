# heroku toolbelt is used for migration from heroku
class heroku {
  exec { "toolbelt":
    command => "wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh",
    unless  => "test -e /usr/local/heroku/bin/heroku"
  }
}
