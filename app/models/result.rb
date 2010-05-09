class Result < ActiveRecord::Base
  belongs_to :report
  belongs_to :part

  validates_presence_of :report, :part, :succeeded, :description
  acts_as_list scope: :report
end
