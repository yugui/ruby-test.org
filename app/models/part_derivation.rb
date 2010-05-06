class PartDerivation < ActiveRecord::Base
  belongs_to :from, class_name: 'Part'
  belongs_to :to, class_name: 'Part'
end
