class KeyPerson < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_one :customer
  has_many :visit_records
  belongs_to :user

  def self.search_name(value)
    KeyPerson.where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end
end
