class Platform < ActiveRecord::Base
  validates_presence_of :arch, :os
  validates_uniqueness_of :os, scope: %w[ arch misc ]
end
