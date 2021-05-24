class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.integer :key_person_id
      t.integer :sales_end_id
      t.float :latitude
      t.float :longitude
      t.integer :system, default: 0
      t.integer :user_id

      t.timestamps
    end
    change_column_null :customers, :name, false
    add_index :customers, :name, unique: true
    add_index :customers, :address, unique: true
  end
end
