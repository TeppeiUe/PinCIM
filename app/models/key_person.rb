class KeyPerson < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }

  has_one :customer
  has_many :visit_records
  belongs_to :user
end
