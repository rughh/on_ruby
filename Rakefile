# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

HamburgOnRuby::Application.load_tasks

MetricFu::Configuration.run do |config|  
  config.rcov[:rcov_opts] << "-Ispec"  
end rescue nil

task :default=>['db:migrate', 'spec']