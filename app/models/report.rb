class Report < ActiveRecord::Base
  belongs_to :site
  belongs_to :revision
  has_many :results

  validates_presence_of :site, :revision
end
