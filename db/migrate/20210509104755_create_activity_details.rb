class CreateActivityDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_details do |t|
      t.integer :visit_record_id
      t.integer :activity_id

      t.timestamps
    end
    change_column_null :activity_details, :visit_record_id, false
    change_column_null :activity_details, :activity_id, false
    add_index :activity_details, [:visit_record_id, :activity_id], unique: true 
  end
end
