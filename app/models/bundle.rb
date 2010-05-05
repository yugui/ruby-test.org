class Bundle < ActiveRecord::Base
  belongs_to :revision
  validates_presence_of :signature, :name, :revision

  has_many :bundlings, foreign_key: 'in_id'
  has_many :parts, through: :bundlings, source: 'of'

  def add_part(part)
    bundlings.create of: part
  end

  def self.find_or_create_by_attrs_and_parts(signature, name, revision, parts)
    bundle = find_by_signature_and_revision_id(signature, revision.id)
    if bundle
      raise ArgumentError, "expected name #{bundle.name.dump} but got #{name.dump}. wrong signature?" if bundle.name != name

      return bundle
    else
      bundle = Bundle.create signature: signature, name: name, revision: revision
      parts.each do |attrs|
        part = Part.find_or_create_by_attrs(signature, attrs[:identifier], attrs[:name], revision)
        bundle.add_part(part)
      end
      return bundle
    end
  end
end
