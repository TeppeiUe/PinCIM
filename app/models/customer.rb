class Customer < ApplicationRecord
  validates :name, presence: true

  belongs_to :sales_end
  belongs_to :key_person

  def self.search_name(value)
    Customer.where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end
end
