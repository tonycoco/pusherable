require 'rubygems'
require 'bundler/setup'
require 'mongoid'
require 'mongoid-rspec'
require 'database_cleaner'
require 'pusher'

Pusher.app_id = '1234567'
Pusher.secret = 'FAKE'
Pusher.key    = 'FAKE'

require 'pusherable'

Mongoid.configure do |config|
  config.connect_to("pusherable-test")
end

load File.dirname(__FILE__) + '/support/mongoid_models.rb'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.orm = :mongoid
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    Mongoid.purge!
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
