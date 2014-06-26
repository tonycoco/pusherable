require "pusherable/version"
require "active_support"
require "active_record"

module Pusherable
  extend ::ActiveSupport::Concern

  module ClassMethods
    def pusherable?
      false
    end

    def pusherable(pusherable_channel="test_channel")
      raise "Please `gem install pusher` and configure it to run in your app!" if Pusher.app_id.blank? || Pusher.key.blank? || Pusher.secret.blank?

      class_attribute :pusherable_channel
      class_attribute :pusherable_triggers_active

      self.pusherable_channel = pusherable_channel
      self.pusherable_triggers_active = true

      class << self
        def pusherable_triggers?
          pusherable_triggers_active
        end

        def activate_pusherable_triggers
          self.pusherable_triggers_active = true
        end

        def deactivate_pusherable_triggers
          self.pusherable_triggers_active = false
        end
      end

      class_eval do
        if defined?(Mongoid) && defined?(Mongoid::Document) && include?(Mongoid::Document)
          after_create :pusherable_trigger_create, if: :pusherable_triggers_active
          after_update :pusherable_trigger_update, if: :pusherable_triggers_active
          before_destroy :pusherable_trigger_destroy, if: :pusherable_triggers_active
        else
          after_commit :pusherable_trigger_create, on: :create, if: :pusherable_triggers_active
          after_commit :pusherable_trigger_update, on: :update, if: :pusherable_triggers_active
          after_commit :pusherable_trigger_destroy, on: :destroy, if: :pusherable_triggers_active
        end

        def self.pusherable?
          true
        end

        self.singleton_class.send(:alias_method, :generated_pusherable_channel, :pusherable_channel)
        
        def self.pusherable_channel(obj=nil)
          if generated_pusherable_channel.respond_to? :call
            if generated_pusherable_channel.arity > 0
              generated_pusherable_channel.call(obj)
            else
              generated_pusherable_channel.call
            end
          else
            generated_pusherable_channel
          end
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
end

if defined?(ActiveRecord) && defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, Pusherable
end

if defined?(Mongoid) && defined?(Mongoid::Document)
  Mongoid::Document.send :include, Pusherable
end
