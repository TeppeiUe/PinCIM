class KeyPerson < ApplicationRecord
  validates :name, presence: true

  def self.search_name(value)
    KeyPerson.where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end
end
