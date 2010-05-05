require 'spec_helper'

describe Revision do
  fixtures :revisions
  before(:each) do
    @valid_attributes = {
      :identifier => "1",
      :committed_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Revision.create!(@valid_attributes)
  end

  it "should be comparable" do
    Revision.should < Comparable
  end

  it "should have the order by committed_at attribute" do
    revisions(:first).should < revisions(:second)
    revisions(:second).should > revisions(:first)
  end
end
