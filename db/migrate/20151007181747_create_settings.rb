class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :setting_name
      t.text :value

      t.timestamps null: false
    end
    add_index :settings, :setting_name
  end
end
