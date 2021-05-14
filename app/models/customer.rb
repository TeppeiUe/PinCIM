class Customer < ApplicationRecord
  validates :name, presence: true

  belongs_to :sales_end
  belongs_to :key_person
  has_many :visit_records

  geocoded_by :address
  before_validation :geocode

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

  def latest_visit_record
    VisitRecord.find(
      VisitRecord.order(visit_datetime: :desc).
      find_by(customer_id: self.id).id
    )
  end
end
