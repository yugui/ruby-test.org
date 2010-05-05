class Revision < ActiveRecord::Base
  include Comparable
  validates_presence_of :identifier, :committed_at

  def <=>(rhs)
    case rhs
    when Revision
      return self.committed_at <=> rhs.committed_at
    else
      return nil
    end
  end
end
