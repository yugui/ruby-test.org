class Site < ActiveRecord::Base
  belongs_to :platform
  belongs_to :owner, class_name: 'User'

  validates_presence_of :platform, :owner
end
