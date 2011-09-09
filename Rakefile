# encoding: utf-8
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require "rake"

HamburgOnRuby::Application.load_tasks

task :travis do
  ["rake db:migrate", "rspec spec -f d"].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $?.exitstatus == 0
  end
  puts "we looooooooooove travis-ci <3"
end