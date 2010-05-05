class Bundling < ActiveRecord::Base
  belongs_to :of, class_name: 'Part'
  belongs_to :in, class_name: 'Bundle'
end
