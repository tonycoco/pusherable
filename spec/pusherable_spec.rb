require 'spec_helper'

describe Pusherable do
  before do
    Pusher.stub(:trigger).and_return true
  end

  describe 'setup' do
    it 'should make ActiveRecord models pusherable' do
      NonPusherableModel.pusherable?.should == false
      PusherableModel.pusherable?.should == true
    end
  end

  describe 'callbacks' do
    before(:each) do
      @pusherable_model = PusherableModel.new
      @non_pusherable_model = NonPusherableModel.new
    end

    it 'should trigger after create' do
      @pusherable_model.should_receive(:pusherable_trigger_create).once
      @pusherable_model.save
    end

    it 'should trigger after update' do
      @pusherable_model.should_receive(:pusherable_trigger_create).once
      @pusherable_model.save
      @pusherable_model.should_receive(:pusherable_trigger_update).once
      @pusherable_model.save!
    end

    it 'should trigger after update' do
      @pusherable_model.should_receive(:pusherable_trigger_create).once
      @pusherable_model.save
      @pusherable_model.should_receive(:pusherable_trigger_destroy).once
      @pusherable_model.destroy
    end

    it 'should not trigger events on a regular ActiveRecord model' do
      @non_pusherable_model.should_not_receive(:pusherable_trigger_create)
      @non_pusherable_model.save
      @non_pusherable_model.should_not_receive(:pusherable_trigger_update)
      @non_pusherable_model.save
      @non_pusherable_model.should_not_receive(:pusherable_trigger_destroy)
      @non_pusherable_model.destroy
    end
  end

  describe 'channels' do
    it 'should get and set the channel to push to' do
      DefaultedPusherableModel.pusherable_channel.should == 'test_channel'
      PusherableModel.pusherable_channel.should == 'our_channel'

      default_model = DefaultedPusherableModel.new
      setup_model = PusherableModel.new

      default_model.pusherable_channel.should == 'test_channel'
      setup_model.pusherable_channel.should == 'our_channel'
    end
  end
end
