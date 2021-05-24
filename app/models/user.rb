class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :timeoutable

  has_many :activities
end
