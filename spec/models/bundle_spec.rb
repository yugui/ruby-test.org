require 'spec_helper'

describe Bundle do
  fixtures :revisions, :parts, :bundles, :bundlings
  before(:each) do
    @valid_attributes = {
      signature: "tag:ruby-test.org,2010:bundle/configure",
      name: "configure",
      revision: revisions(:first)
    }
  end

  it "should create a new instance given valid attributes" do
    Bundle.create!(@valid_attributes)
  end

  it "can have a part shared by another bundle" do
    b = bundles(:a_test_case)
    part = parts(:yet_another_part)
    b.parts.should_not include(part)

    b.add_part(part)
    b.parts.reload
    b.parts.should include(part)
    part.bundles.should include(b)
  end
end

describe Bundle, '.find_or_create_by_attrs_and_parts' do
end
