class PusherableModel < ActiveRecord::Base
  pusherable('our_channel')
end
