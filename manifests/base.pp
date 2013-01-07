File {
  owner => root,
  group => root,
  mode  => 0644,
}
Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
}

import "nodes.pp"
