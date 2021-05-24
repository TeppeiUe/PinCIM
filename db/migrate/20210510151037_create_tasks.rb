class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :visit_record_id
      t.string :title
      t.text :content
      t.datetime :deadline
      t.boolean :is_active, default: true
      t.integer :user_id

      t.timestamps
    end
    change_column_null :tasks, :visit_record_id, false
    change_column_null :tasks, :title, false
  end
end
