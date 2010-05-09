require 'spec_helper'

describe Result do
  fixtures :platforms, :sites, :revisions, :reports, :parts
  before(:each) do
    @valid_attributes = {
      report: reports(:third_on_a_sparc_solaris),
      part: parts(:a_part_after_modified),
      succeeded: true,
      description: '.',
      detail: 'ATestCase#test_method_b'
    }
  end

  it "should create a new instance given valid attributes" do
    Result.create!(@valid_attributes)
  end
end
