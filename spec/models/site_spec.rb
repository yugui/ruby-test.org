require 'spec_helper'

describe Site do
  fixtures :platforms

  before(:each) do
    @valid_attributes = {
      platform: platforms(:mswin32),
      owner: User.make
    }
  end

  it "should create a new instance given valid attributes" do
    Site.create!(@valid_attributes)
  end
end
