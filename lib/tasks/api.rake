namespace :api do
  desc "calls the api with given api-key"
  task :call, [:key] do |task, args|
    key = args[:key]
    url = "http://hamburg.onruby.de/api.json"
    cmd = "curl --header 'x-api-key: #{key}' #{url}"
    puts "executing: #{cmd}"
    pp JSON.parse(`#{cmd}`)
  end
end
