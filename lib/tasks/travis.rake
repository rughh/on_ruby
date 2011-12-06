namespace :travis do
  desc 'build task for travis-ci'
  task :build do
    ["rake db:migrate", "rspec spec -f d"].each do |cmd|
      puts "Starting to run #{cmd}..."
      system("export DISPLAY=:99.0 && bundle exec #{cmd}")
      raise "#{cmd} failed!" unless $?.exitstatus == 0
    end
    puts "we looooooooooove travis-ci <3"
  end
end