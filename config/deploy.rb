require 'bundler/capistrano'

# ssh_options[:port] = 2222
# ssh_options[:keys] = "~/.vagrant.d/insecure_private_key"

set :user,          "deployer"
set :group,         "deployer"
set :deploy_to,     "/var/onruby"
set :use_sudo,      false
set :deploy_via,    :copy
set :copy_strategy, :export
set :branch,        "capistrano"

set :application, "onruby"
set :scm,         :git
set :repository,  "https://github.com/phoet/on_ruby.git"

server "176.58.97.120", :web, :app, :db, :primary => true

after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :copy_in_database_yml, :roles => :app, :except => { :no_release => true }  do
    run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
  end
end
before "deploy:assets:precompile", "deploy:copy_in_database_yml"
