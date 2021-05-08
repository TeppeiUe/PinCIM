class KeyPerson < ApplicationRecord
  validates :name, presence: true

  has_one :customer

  def self.search_name(value)
    KeyPerson.where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end
end
