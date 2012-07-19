# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aggro/version'

Gem::Specification.new do |gem|
  gem.name          = "aggro"
  gem.version       = Aggro::VERSION
  gem.authors       = ["Brian Rose"]
  gem.email         = ["brian@heimidal.net"]
  gem.description   = %q{A social aggregator that will help you avoid the common frustration of API hell.}
  gem.summary       = %q{Aggro provides aggregation from multiple social media sites. The primary goals are a simple API and common object types across all services.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
