class Customer < ApplicationRecord
  validates :name, presence: true
  validates :name, :address, uniqueness: true

  belongs_to :sales_end
  belongs_to :key_person
  has_many :visit_records
  belongs_to :user

  geocoded_by :address
  before_validation :geocode, if: :address_changed?

  enum system: {
    systemA: 0,
    systemB: 1,
    systemC: 2,
  }

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
    visit_records.order(visit_datetime: :desc).first
  end
end
