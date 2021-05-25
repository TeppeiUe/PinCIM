class Belong < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }

  has_many :sales_ends
  has_many :visit_records
  belongs_to :user
end
