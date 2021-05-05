class SalesEnd < ApplicationRecord
  validates :name, presence: true

  def self.search_name(value)
    SalesEnd.where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end
end
