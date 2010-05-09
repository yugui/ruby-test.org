require 'spec_helper'

describe Platform do
  before(:each) do
    @valid_attributes = {
      :arch => "i386",
      :os => "linux",
      :misc => nil
    }
  end

  it "should create a new instance given valid attributes" do
    Platform.create!(@valid_attributes)
  end
end
