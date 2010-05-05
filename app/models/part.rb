class Part < ActiveRecord::Base
  belongs_to :first_appeared_at, :class_name => "Revision"
  has_many :bundlings, foreign_key: 'of_id'
  has_many :bundles, through: :bundlings, source: 'in'

  validates_presence_of :identifier, :name, :first_appeared_at
end
