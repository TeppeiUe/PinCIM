class Activity < ApplicationRecord
  validates :name, :category, presence: true

  has_many :activity_details

  enum category: {
    プレゼン: 0,
    定期訪問: 1,
    打ち合せ: 2,
    PR: 3,
  }

  def self.search_name(value)
    Activity.where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end
end