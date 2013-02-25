require 'database_cleaner'
require 'active_record'
require 'pusher'
require 'pusherable'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
