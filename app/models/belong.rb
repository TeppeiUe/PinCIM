class Belong < ApplicationRecord
  validates :name, presence: true

  has_many :sales_ends
  has_many :visit_records

  def self.search_name(value)
    Belong.where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end
end
