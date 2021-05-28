class ChangeCustomersColumn < ActiveRecord::Migration[5.2]
  def up
    add_column :customers, :note, :text
    change_table :customers do |t|
      t.change :system, :string, default: nil
    end
  end

  def down
    change_table :customers do |t|
      t.change :system, :integer, default: 0
    end
  end
end
