require "spec_helper"
require "mongoid"
require "mongoid-rspec"
require "pusherable"

Mongoid.configure do |config|
  config.connect_to("pusherable-test")
end

load File.dirname(__FILE__) + "/support/models/mongoid.rb"
