class AddReviewedToCivilEntries < ActiveRecord::Migration
  def change
    add_column :civil_entries, :reviewed, :boolean, :default => false
  end
end
