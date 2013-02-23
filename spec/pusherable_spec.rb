require 'spec_helper'

describe Pusherable do
  before(:each) do
    @pusherable_model = PusherableModel.new
  end

  it 'should make ActiveRecord models pusherable' do
    PusherableModel.pusherable?.should == true
  end
end
