class AddGeocodingToCivilEntries < ActiveRecord::Migration
  def change
    add_column :civil_entries, :latitude, :float
    add_column :civil_entries, :longitude, :float
    add_column :civil_entries, :address, :string
  end
end
