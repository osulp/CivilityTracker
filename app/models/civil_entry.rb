class CivilEntry < ActiveRecord::Base
  validates :serial, :presence => true
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :reverse_geocode, :if => ->(obj){ obj.latitude.present? && obj.longitude.present? && (obj.latitude_changed? || obj.longitude_changed? || obj.address.blank?) }

  def review!
    self.reviewed = true
  end
end
