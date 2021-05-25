class Activity < ApplicationRecord
  validates :name, :category, presence: true
  validates :name, uniqueness: { scope: :user_id }

  has_many :activity_details
  belongs_to :user

  enum category: {
    プレゼン: 0,
    定期訪問: 1,
    打ち合せ: 2,
    PR: 3,
  }
end
