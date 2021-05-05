class CreateSalesEnds < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_ends do |t|
      t.string :name
      t.integer :belong_id
      t.string :post
      t.string :telephone_number
      t.text :note

      t.timestamps
    end
    change_column_null :sales_ends, :name, false
    add_index :sales_ends, :name
  end
end
