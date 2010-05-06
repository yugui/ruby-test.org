class Bundle < ActiveRecord::Base
  belongs_to :revision
  validates_presence_of :signature, :name, :revision

  has_many :bundlings, foreign_key: 'in_id'
  has_many :parts, through: :bundlings, source: 'of'

  has_many :derivations, class_name: 'BundleDerivation', foreign_key: 'from_id'
  has_many :derivatives, through: :derivations, source: 'to'

  has_many :originations, class_name: 'BundleDerivation', foreign_key: 'to_id'
  has_many :origins, through: :originations, source: 'from'

  def add_part(part)
    bundlings.create of: part
  end

  def self.find_or_create_by_attrs_and_parts(signature, name, revision, parts)
    bundle = find_by_signature_and_revision_id(signature, revision.id)
    if bundle
      raise ArgumentError, "expected name #{bundle.name.dump} but got #{name.dump}. wrong signature?" if bundle.name != name

      known_idents = bundle.parts.map(&:identifier)
      parts.each do |attrs|
        next if known_idents.include?(attrs[:identifier])
        part = Part.find_or_create_by_attrs(signature, attrs[:identifier], attrs[:name], revision)
        bundle.bundlings.create of: part
      end
      bundle.parts.reload

      return bundle
    else
      bundle = Bundle.create signature: signature, name: name, revision: revision
      parts.each do |attrs|
        part = Part.find_or_create_by_attrs(signature, attrs[:identifier], attrs[:name], revision)
        bundle.add_part(part)
      end

      prev_bundle = find :first,
        include: 'revision',
        conditions: ['signature = ? AND revisions.committed_at < ?', signature, revision.committed_at],
        order: 'revisions.committed_at DESC'
      bundle.originations.create from: prev_bundle if prev_bundle

      next_bundle = find :first,
        include: 'revision',
        conditions: ['signature = ? AND revisions.committed_at > ?', signature, revision.committed_at],
        order: 'revisions.committed_at ASC'
      bundle.derivations.create to: next_bundle if next_bundle

      if prev_bundle and next_bundle
        der = prev_bundle.derivations.find_by_to_id(next_bundle.id)
        der.destroy
      end
      return bundle
    end
  end
end
