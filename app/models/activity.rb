class Activity < ApplicationRecord
  validates :name, :category, presence: true

  enum category: {
    プレゼン: 0,
    定期訪問: 1,
    打ち合せ: 2,
    PR: 3,
  }
end
