require "spec_helper"

describe Pusherable do
  before do
    Pusher.stub(:trigger).and_return true
  end

  describe "mongoid setup" do
    it "should make Mongoid::Document models pusherable" do
      expect(MongoidNonPusherableModel.pusherable?).to be_false
      expect(MongoidPusherableModel.pusherable?).to be_true
    end
  end

  describe "callbacks" do
    let(:pusherable_model) { MongoidPusherableModel.new }
    let(:non_pusherable_model) { MongoidNonPusherableModel.new }

    it "should trigger after create" do
      pusherable_model.should_receive(:pusherable_trigger_create).once
      pusherable_model.save
    end

    it "should trigger after update" do
      pusherable_model.should_receive(:pusherable_trigger_create).once
      pusherable_model.save
      pusherable_model.should_receive(:pusherable_trigger_update).once
      pusherable_model.save!
    end

    it "should trigger after update" do
      pusherable_model.should_receive(:pusherable_trigger_create).once
      pusherable_model.save
      pusherable_model.should_receive(:pusherable_trigger_destroy).once
      pusherable_model.destroy
    end

    it "should not trigger events on a regular Mongoid model" do
      non_pusherable_model.should_not_receive(:pusherable_trigger_create)
      non_pusherable_model.save
      non_pusherable_model.should_not_receive(:pusherable_trigger_update)
      non_pusherable_model.save
      non_pusherable_model.should_not_receive(:pusherable_trigger_destroy)
      non_pusherable_model.destroy
    end
  end

  describe "channels" do
    let(:default_model) { MongoidDefaultedPusherableModel.new }
    let(:setup_model) { MongoidPusherableModel.new }
    let(:callable_model) { MongoidCallablePusherableModel.new }

    it "should get and set the channel to push to" do
      expect(MongoidDefaultedPusherableModel.pusherable_channel).to eq("test_channel")
      expect(MongoidPusherableModel.pusherable_channel).to eq("our_channel")
      expect(MongoidCallablePusherableModel.pusherable_channel).to eq("lambda_channel")

      expect(default_model.pusherable_channel).to eq("test_channel")
      expect(setup_model.pusherable_channel).to eq("our_channel")
      expect(callable_model.pusherable_channel).to eq("lambda_channel")
    end
  end
end
