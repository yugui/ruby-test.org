class Part < ActiveRecord::Base
  belongs_to :first_appeared_at, :class_name => "Revision"
  validates_presence_of :identifier, :name, :first_appeared_at
end
