class CreateBelongs < ActiveRecord::Migration[5.2]
  def change
    create_table :belongs do |t|
      t.string :name
      t.string :address

      t.timestamps
    end
    change_column_null :belongs, :name, false
    add_index :belongs, :name
  end
end
