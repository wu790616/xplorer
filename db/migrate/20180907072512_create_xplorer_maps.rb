class CreateXplorerMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :xplorer_maps do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :strength, :default => 0
      t.timestamps
    end
  end
end
