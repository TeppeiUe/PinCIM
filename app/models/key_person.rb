class KeyPerson < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_one :customer
  has_many :visit_records
  has_many :customer_key_people
  belongs_to :user

  enum sex: {
    男性: 0,
    女性: 1,
  }
end
