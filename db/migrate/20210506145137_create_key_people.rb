class CreateKeyPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :key_people do |t|
      t.string :name
      t.text :career
      t.text :note

      t.timestamps
    end
    change_column_null :key_people, :name, false
    add_index :key_people, :name, unique: true
  end
end
