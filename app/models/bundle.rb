class Bundle < ActiveRecord::Base
  belongs_to :revision
  validates_presence_of :signature, :name, :revision

  has_many :bundlings, foreign_key: 'in_id'
  has_many :parts, through: :bundlings, source: 'of'

  def add_part(part)
    bundlings.create of: part
  end
end
