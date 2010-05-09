class Report < ActiveRecord::Base
  belongs_to :site
  belongs_to :revision

  validates_presence_of :site, :revision
end
