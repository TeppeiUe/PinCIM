class CreateVisitRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :visit_records do |t|
      t.integer :customer_id
      t.integer :key_person_id
      t.integer :belong_id
      t.integer :sales_end_id
      t.datetime :visit_datetime
      t.integer :system, default: 0
      t.datetime :next_datetime
      t.text :note
      t.integer :rank, default: 0

      t.timestamps
    end
    change_column_null :visit_records, :customer_id, false
    change_column_null :visit_records, :key_person_id, false
    change_column_null :visit_records, :belong_id, false
    change_column_null :visit_records, :sales_end_id, false
    change_column_null :visit_records, :visit_datetime, false
  end
end
