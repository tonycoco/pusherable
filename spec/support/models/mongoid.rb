class MongoidNonPusherableModel
  include Mongoid::Document
end

class MongoidDefaultedPusherableModel
  include Mongoid::Document
  pusherable
end

class MongoidPusherableModel
  include Mongoid::Document
  pusherable("our_channel")
end

class MongoidCallablePusherableModel
  include Mongoid::Document
  field :name, type: String
  pusherable ->(o) { "lambda_channel#{o.name if o}" }
end
