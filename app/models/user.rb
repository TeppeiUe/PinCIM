class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :timeoutable

  has_many :activities
  has_many :belongs
  has_many :key_people
  has_many :sales_ends
  has_many :customers
  has_many :visit_records
  has_many :activity_details
  has_many :tasks
end
