require "rubygems"
require "bundler/setup"
require "pusher"
require "mongoid"
require "mongoid-rspec"
require "active_record"

Pusher.app_id = "123456"
Pusher.secret = "FAKE"
Pusher.key = "FAKE"

require "pusherable"

Mongoid.configure do |config|
  config.connect_to("pusherable_test")
end
load File.dirname(__FILE__) + "/support/models/mongoid.rb"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
load File.dirname(__FILE__) + "/support/schema.rb"
load File.dirname(__FILE__) + "/support/models/sqlite.rb"
