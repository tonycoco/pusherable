require "pusherable/version"
require "active_support"
require "active_record"

module Pusherable
  extend ::ActiveSupport::Concern

  module ClassMethods
    def pusherable?
      false
    end

    def pusherable(channel="test_channel")
      raise "Please `gem install pusher` and configure it to run in your app!" if Pusher.app_id.blank? || Pusher.key.blank? || Pusher.secret.blank?

      class_attribute :pusherable_channel_obj
      self.pusherable_channel_obj = channel

      class << self
        def pusherable_triggers?
          Thread.current.thread_variable_get("#{self.name.underscore}_pusherable_triggers_active") != false
        end

        def activate_pusherable_triggers
          Thread.current.thread_variable_set "#{self.name.underscore}_pusherable_triggers_active", true
        end

        def deactivate_pusherable_triggers
          Thread.current.thread_variable_set "#{self.name.underscore}_pusherable_triggers_active", false
        end

        def pusherable?
          true
        end

        def pusherable_channel(obj=nil)
          if pusherable_channel_obj.respond_to? :call
            if pusherable_channel_obj.arity > 0
              pusherable_channel_obj.call(obj)
            else
              pusherable_channel_obj.call
            end
          else
            pusherable_channel_obj
          end
        end
      end

      class_eval do
        if defined?(Mongoid) && defined?(Mongoid::Document) && include?(Mongoid::Document)
          after_create :pusherable_trigger_create, if: :pusherable_triggers?
          after_update :pusherable_trigger_update, if: :pusherable_triggers?
          before_destroy :pusherable_trigger_destroy, if: :pusherable_triggers?
        else
          after_commit :pusherable_trigger_create, on: :create, if: :pusherable_triggers?
          after_commit :pusherable_trigger_update, on: :update, if: :pusherable_triggers?
          after_commit :pusherable_trigger_destroy, on: :destroy, if: :pusherable_triggers?
        end

        def pusherable_channel
          self.class.pusherable_channel(self)
        end

        [:pusherable_triggers?, :activate_pusherable_triggers, :deactivate_pusherable_triggers].each do |method|
          define_method method do
            self.class.send method
          end
        end

        private

        def pusherable_class_name
          self.class.name.underscore
        end

        def pusherable_trigger_create
          Pusher.trigger(pusherable_channel, "#{pusherable_class_name}.create", to_json)
        end

        def pusherable_trigger_update
          Pusher.trigger(pusherable_channel, "#{pusherable_class_name}.update", to_json)
        end

        def pusherable_trigger_destroy
          Pusher.trigger(pusherable_channel, "#{pusherable_class_name}.destroy", to_json)
        end
      end
    end
  end
end

if defined?(ActiveRecord) && defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, Pusherable
end

if defined?(Mongoid) && defined?(Mongoid::Document)
  Mongoid::Document.send :include, Pusherable
end
