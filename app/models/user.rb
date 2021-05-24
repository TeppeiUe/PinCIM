class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :timeoutable

  has_many :activities
  has_many :belongs
  has_many :key_people
end
