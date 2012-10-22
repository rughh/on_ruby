File.open(".git/config", "a") do |f|
  f.puts <<-EOF
[remote "heroku"]
    url = url = git@heroku.com:hamburg-on-ruby.git
    fetch = +refs/heads/*:refs/remotes/heroku/* # had to change this into remote name instead of app name
EOF
end

known_hosts = File.expand_path("~/.ssh/config")
File.open(known_hosts, "a") do |f|
  f.puts <<-EOF
Host heroku.com
   StrictHostKeyChecking no
   CheckHostIP no
   UserKnownHostsFile=/dev/null
EOF
end
