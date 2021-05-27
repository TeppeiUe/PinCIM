class Customer < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }

  belongs_to :sales_end
  belongs_to :key_person
  has_many :visit_records
  belongs_to :user

  geocoded_by :address
  before_validation :geocode, if: :address_changed?

  def self.search_address(value)
    where("address LIKE ?", "%#{sanitize_sql_like(value)}%")
  end

  def self.search_customer(how, value)
    if how == "customer_name"
      search_name(value)
    elsif how == "customer_address"
      search_address(value)
    end
  end

  def latest_visit_record
    visit_records.order(visit_datetime: :desc).first
  end
end
