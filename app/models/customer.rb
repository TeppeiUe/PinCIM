class Customer < ApplicationRecord
  validates :name, presence: true

  belongs_to :sales_end
  belongs_to :key_person

  def self.search_name(value)
    Customer.where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end

  def self.search_address(value)
    Customer.where("address LIKE ?", "%#{sanitize_sql_like(value)}%")
  end

  def self.search_customer(how, value)
    if how == "customer_name"
      Customer.search_name(value)
    elsif how == "customer_address"
      Customer.search_address(value)
    end
  end
end
