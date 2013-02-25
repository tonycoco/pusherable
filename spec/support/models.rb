class NonPusherableModel < ActiveRecord::Base
end

class DefaultedPusherableModel < ActiveRecord::Base
  pusherable
end

class PusherableModel < ActiveRecord::Base
  pusherable('our_channel')
end
