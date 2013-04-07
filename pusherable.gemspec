# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pusherable/version'

Gem::Specification.new do |gem|
  gem.name          = 'pusherable'
  gem.version       = Pusherable::VERSION
  gem.authors       = ['Tony Coconate']
  gem.email         = ['me@tonycoconate.com']
  gem.description   = %q{Adds callback hooks for your ActiveModel models for sending messages to a Pusher channel.}
  gem.summary       = %q{Adds callback hooks to your models for sending messages to a Pusher channel.}
  gem.homepage      = 'https://github.com/tonycoco/pusherable'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'mongoid',       '>= 3'
  gem.add_development_dependency 'mongoid-rspec', '>= 1.6'

  gem.add_development_dependency 'activerecord',  '>= 3.2.0'

  gem.add_development_dependency 'pusher', '~> 0.11.0'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'rspec', '>= 2.12.0'

  gem.add_development_dependency 'acts_as_fu'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'rake'
end
