class ChangeKeyPeopleColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :key_people, :post, :string
    add_column :key_people, :email, :string
    add_column :key_people, :sex, :intger, default: 0
    remove_column :key_people, :career, :text
  end
end
