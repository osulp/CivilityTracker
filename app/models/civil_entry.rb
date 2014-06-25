class CivilEntry < ActiveRecord::Base
  validates :serial, :presence => true
end
