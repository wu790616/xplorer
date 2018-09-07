class CreateUserXMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :user_x_maps do |t|
      t.integer :user_id
      t.integer :from_id
      t.integer :to_id
      t.integer :strength
      t.timestamps
    end
  end
end
