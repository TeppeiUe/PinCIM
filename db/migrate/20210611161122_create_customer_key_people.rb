class CreateCustomerKeyPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_key_people do |t|
      t.integer :customer_id
      t.integer :key_person_id
      t.date :start_period
      t.date :end_period
      t.integer :user_id

      t.timestamps
    end
    change_column_null :customer_key_people, :customer_id, false
    change_column_null :customer_key_people, :key_person_id, false
    add_index :customer_key_people, :customer_id
  end
end
