# encoding: utf-8
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
require 'ci/reporter/rake/rspec'

HamburgOnRuby::Application.load_tasks

MetricFu::Configuration.run do |config|  
  config.rcov[:rcov_opts] << "-Ispec"  
end rescue nil

task :travis_ci=>['db:migrate', 'ci:setup:rspec', 'spec'] do
  puts "*" * 50
  puts "i love travis-ci "
  puts "*" * 50
end