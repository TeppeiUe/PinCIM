class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :category, default: 0

      t.timestamps
    end
    change_column_null :activities, :name, false
    change_column_null :activities, :category, false
    add_index :activities, :name
    add_index :activities, :category
  end
end
