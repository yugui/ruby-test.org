class Part < ActiveRecord::Base
  belongs_to :first_appeared_at, :class_name => "Revision"
  has_many :bundlings, foreign_key: 'of_id'
  has_many :bundles, through: :bundlings, source: 'in'

  has_many :derivations, class_name: 'PartDerivation', foreign_key: 'from_id'
  has_many :derivatives, through: :derivations, source: 'to'

  has_many :originations, class_name: 'PartDerivation', foreign_key: 'to_id'
  has_many :origins, through: :originations, source: 'from'


  validates_presence_of :identifier, :name, :first_appeared_at

  def self.find_or_create_by_attrs(parent_signature, identifier, name, revision)
    part = find_by_identifier(identifier)
    if part
      raise ArgumentError, "expected name #{part.name.dump} but got #{name.dump}. wrong identifier?" if part.name != name
      if part.first_appeared_at > revision
        part.first_appeared_at = revision
        part.save! 
      end
    else
      part = Part.create identifier: identifier, name: name, first_appeared_at: revision
    end
    return part
  end
end
