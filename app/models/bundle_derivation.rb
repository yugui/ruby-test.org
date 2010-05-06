class BundleDerivation < ActiveRecord::Base
  belongs_to :from, class_name: 'Bundle'
  belongs_to :to, class_name: 'Bundle'
end
