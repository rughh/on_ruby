# Adapted from
# http://github.com/chriseppstein/compass/issues/issue/130
# and other posts.

# Create the dir
require 'fileutils'
FileUtils.mkdir_p(Rails.root.join("tmp", "stylesheets"))

Sass::Plugin.on_updating_stylesheet do |template, css|
  puts "Compiling #{template} to #{css}"
end

Rails.configuration.middleware.insert_before('Rack::Sendfile', 'Rack::Static', :urls => ['/stylesheets'], :root => "#{Rails.root}/tmp")
