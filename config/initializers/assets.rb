# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join("node_modules")

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# since updating to Rails 6 and adding webpacker, the files need explicit listing
# there should be a better solution
Rails.application.config.assets.precompile += %w(
  labels/cologne.js
  application.js

  labels/barcelona.css
  labels/bonn.css
  labels/cologne.css
  labels/hamburg.css
  labels/leipzig.css
  labels/madridrb.css
  labels/munich.css
  labels/railsgirlshh.css
  labels/saar.css
  application.css
)
