class AddReviewedToCivilEntries < ActiveRecord::Migration
  def change
    add_column :civil_entries, :reviewed, :boolean
  end
end
