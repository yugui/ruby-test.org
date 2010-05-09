require 'spec_helper'

describe Report do
  fixtures :platforms, :sites, :revisions
  before(:each) do
    @valid_attributes = {
      site: sites(:a_mswin32),
      revision: revisions(:third)
    }
  end

  it "should create a new instance given valid attributes" do
    Report.create!(@valid_attributes)
  end
end
