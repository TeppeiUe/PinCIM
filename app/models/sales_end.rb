class SalesEnd < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }

  belongs_to :belong
  has_many :customers
  has_many :visit_records
  belongs_to :user

  def self.search_belong(belong_ids)
    where(belong_id: belong_ids)
  end

  def self.search_sales_end(how, value)
    if how == "sales_end_name"
      search_name(value)
    elsif how == "sales_end_belong_name"
      search_belong(
        Belong.search_name(value).pluck(:id)
      )
    end
  end
end
