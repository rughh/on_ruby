# -*- encoding: utf-8 -*-
require File.expand_path('../lib/whitelabel/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Peter Schröder"]
  gem.email         = ["phoetmail@googlemail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "whitelabel"
  gem.require_paths = ["lib"]
  gem.version       = Whitelabel::VERSION

  gem.add_development_dependency('rspec', '~> 2.9')
  gem.add_development_dependency('pry', '~> 0.9')
end
