class SalesEnd < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :belong
  has_many :customers
  has_many :visit_records
  belongs_to :user

  def self.search_name(value)
    SalesEnd.where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end

  def self.search_belong(belong_ids)
    SalesEnd.where(belong_id: belong_ids)
  end

  def self.search_sales_end(how, value)
    if how == "sales_end_name"
      SalesEnd.search_name(value)
    elsif how == "sales_end_belong_name"
      SalesEnd.search_belong(
        Belong.search_name(value).pluck(:id)
      )
    end
  end
end
