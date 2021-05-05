class Belong < ApplicationRecord
  validates :name, presence: true

  def self.search_name(value)
    Belong.where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end
end
