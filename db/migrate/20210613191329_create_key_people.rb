class CreateKeyPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :key_people do |t|
      t.string :name
      t.string :post
      t.string :email
      t.integer :sex, default: 0
      t.text :note
      t.integer :user_id

      t.timestamps
    end
    change_column_null :key_people, :name, false
    add_index :key_people, [:name, :user_id], unique: true
  end
end
