require 'spec_helper'

describe Part do
  fixtures :revisions, :parts
  before(:each) do
    @valid_attributes = {
      identifier: "tag:ruby-test.org,2010:part/ffffffffffffffffffffffffffffffffffffffff",
      name: "it should be blahblah",
      first_appeared_at: revisions(:first),
    }
  end

  it "should create a new instance given valid attributes" do
    Part.create!(@valid_attributes)
  end
end
