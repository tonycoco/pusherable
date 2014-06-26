# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pusherable/version"

Gem::Specification.new do |gem|
  gem.name          = "pusherable"
  gem.version       = Pusherable::VERSION
  gem.authors       = ["Tony Coconate"]
  gem.email         = ["me@tonycoconate.com"]
  gem.description   = %q{Adds callback hooks for your ActiveModel models for sending messages to a Pusher channel.}
  gem.summary       = %q{Adds callback hooks to your models for sending messages to a Pusher channel.}
  gem.homepage      = "https://github.com/tonycoco/pusherable"
  gem.licenses      = ["MIT"]

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activerecord", ">= 3.2.0"
  gem.add_dependency "activesupport", ">= 3.2.0"
  gem.add_dependency "pusher", "~> 0.12.0"
  gem.add_development_dependency "mongoid", ">= 3.1.5"
  gem.add_development_dependency "mongoid-rspec", ">= 1.9.0"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.14.0"
  gem.add_development_dependency "sqlite3"
end
