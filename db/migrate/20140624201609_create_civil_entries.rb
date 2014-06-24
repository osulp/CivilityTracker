class CreateCivilEntries < ActiveRecord::Migration
  def change
    create_table :civil_entries do |t|
      t.integer :serial
      t.text :reason

      t.timestamps
    end
    add_index :civil_entries, :serial
  end
end
