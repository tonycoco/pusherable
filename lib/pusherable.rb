require 'pusherable/version'

module Pusherable
  def pusherable?
    false
  end

  def pusherable(pusherable_channel='test_channel')
    raise "Please `gem install pusher` and configure it to run in your app!" if Pusher.app_id.blank? || Pusher.key.blank? || Pusher.secret.blank?

    class_attribute :pusherable_channel
    self.pusherable_channel = pusherable_channel

    class_eval do
      after_create :pusherable_trigger_create
      after_update :pusherable_trigger_update
      before_destroy :pusherable_trigger_destroy

      def self.pusherable?
        true
      end

      private

      def pusherable_class_name
        self.class.name.underscore
      end

      def pusherable_trigger_create
        Pusher.trigger(pusherable_channel, "#{pusherable_class_name}.create", self.to_json)
      end

      def pusherable_trigger_update
        Pusher.trigger(pusherable_channel, "#{pusherable_class_name}.update", self.to_json)
      end

      def pusherable_trigger_destroy
        Pusher.trigger(pusherable_channel, "#{pusherable_class_name}.destroy", self.to_json)
      end
    end
  end
end

if defined?(::ActiveRecord) && defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Pusherable
end

if defined?(::Mongoid) && defined?(::Mongoid::Document)
  Mongoid::Document.extend Pusherable
end
