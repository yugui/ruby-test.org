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

describe Bundle, '::find_or_create_by_attrs_and_parts' do
  fixtures :revisions, :parts, :bundles, :bundlings

  it "returns a exactly matching bundle if exists" do
    expected = bundles(:a_test_case)
    parts_attrs = expected.parts.map{|p| {identifier: p.identifier, name: p.name} }

    actual = nil
    lambda {
      actual = Bundle.find_or_create_by_attrs_and_parts \
        expected.signature, expected.name, expected.revision, parts_attrs
    }.should_not change(Part, :count)

    actual.should == expected
  end

  it "raises an exception if a matching bundle exists but its name differs from the passed name" do
    expected = bundles(:a_test_case)
    parts_attrs = expected.parts.map{|p| {identifier: p.identifier, name: p.name} }

    lambda {
      Bundle.find_or_create_by_attrs_and_parts \
        expected.signature, "something different", expected.revision, parts_attrs
    }.should raise_error(ArgumentError)
  end

  describe 'the case that a new bundle is created', :shared => true do
    before do
      @part_desc = {
        identifier: parts(:a_part).identifier,
        name: parts(:a_part).name,
      }
    end
    before do
      @signature = "tag:ruby-test.org,2010:bundle/test/ATestCase"
      @name = "ATestCase"
      @revision = revisions(:fourth)
      @finding = lambda do
        Bundle.find_or_create_by_attrs_and_parts(@signature, @name, @revision, [@part_desc])
      end
    end

    it "should create a new bundle" do
      @finding.should change(Bundle, :count).by(1)
    end

    it "should return a bundle with the passed signature" do
      bundle = @finding.call
      bundle.signature.should == @signature
    end
    it "should return a bundle with the passed name" do
      bundle = @finding.call
      bundle.name.should == @name
    end
    it "should return a bundle with the passed revision" do
      bundle = @finding.call
      bundle.revision.should == @revision
    end
  end

  describe "when the signature is unknown and any part is unknown" do
    it_should_behave_like 'the case that a new bundle is created'

    before do
      @signature = "tag:ruby-test.org,2010:bundle/test/SomeUnknownTestCase"
      @name = "SomeUnknownTestCase"
      @part_desc[:identifier] = "tag:ruby-test.org,2010:part/SomeUnknownTestCase#a_part"
    end

    it "should return a bundle with a part and the part was newly created" do
      bundle = nil
      lambda {
        bundle = @finding.call
      }.should change(Part, :count).by(1)

      bundle.parts.count == 1
      part = bundle.parts.first
      part.identifier.should == @part_desc[:identifier]
      part.name.should == @part_desc[:name]
      part.first_appeared_at.should == bundle.revision
    end

    it "should return a bundle without origin" do
      bundle = @finding.call
      bundle.origins.should be_empty
    end
  end

  describe "when the signature is known but there is no matching bundle and is a known part" do
    it_should_behave_like 'the case that a new bundle is created'

    it "should return a bundle with the matching part" do
      bundle = nil
      lambda {
        bundle = @finding.call
      }.should change(Part, :count).by(0)

      bundle.parts.count == 1
      bundle.parts.first.should == parts(:a_part)
    end

    it "modifies first_appeared_at of the part" do
      part = parts(:a_part)
      bundle = @finding.call

      part.reload.first_appeared_at.should == revisions(:first)
    end

    it "derives the returned bundle from the previous bundle" do
      expected_previous_bundle = bundles(:a_test_case_after_modified)

      bundle = @finding.call
      bundle.origins.should include(expected_previous_bundle)
    end
  end

  describe "when the signature is known but there is no matching bundle and is a known part with later revision" do
    it_should_behave_like 'the case that a new bundle is created'

    before do
      @signature = "tag:ruby-test.org,2010:bundle/test/AnotherTestCase"
      @name = "AnotherTestCase"
      @revision = revisions(:first)
    end

    it "should return a bundle with a part and the part was not newly created" do
      bundle = nil
      lambda {
        bundle = @finding.call
      }.should change(Part, :count).by(0)

      bundle.parts.count == 1
      bundle.parts.first.should == parts(:a_part)
    end
    it "modfies first_appeared_at of the part" do
      part = parts(:a_part)

      bundle = @finding.call
      part.reload
      part.first_appeared_at.should == revisions(:first)
    end
    it "returns a bundle with a derivative" do
      expected_next_bundle = bundles(:another_test_case)

      bundle = @finding.call
      bundle.derivatives.should include(expected_next_bundle)
    end
  end

  describe "when there are both prev and next bundle for the signature but not exactly maching one" do
    fixtures :bundle_derivations
    it_should_behave_like 'the case that a new bundle is created'
    before do
      @signature = "tag:ruby-test.org,2010:bundle/test/ATestCase"
      @name = "ATestCase"
      @revision = revisions(:second)
    end

    it "does not modifies first_appeared_at of the part" do
      part = parts(:a_part)
      expected_revision = part.first_appeared_at

      bundle = @finding.call
      part.reload
      part.first_appeared_at.should == expected_revision
    end

    it "inserts the bundle between the prev/next bundles in their derivation chain" do
      prev_bundle = bundles(:a_test_case)
      next_bundle = bundles(:a_test_case_after_modified)
      prev_bundle.derivatives.should == [next_bundle]

      bundle = @finding.call
      prev_bundle.reload; next_bundle.reload
      prev_bundle.derivatives.should == [bundle]
      next_bundle.origins.should == [bundle]
    end
  end
end
