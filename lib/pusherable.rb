require 'pusherable/version'

module Pusherable
  def pusherable?
    false
  end

  def pusherable(pusherable_channel='test_channel')
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
        Pusher.trigger(pusherable_channel, "#{pusherable_class_name}.create", { model_id: self.id })
      end

      def pusherable_trigger_update
        Pusher.trigger(pusherable_channel, "#{pusherable_class_name}.update", { model_id: self.id })
      end

      def pusherable_trigger_destroy
        Pusher.trigger(pusherable_channel, "#{pusherable_class_name}.destroy", { model_id: self.id })
      end
    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Pusherable
end
