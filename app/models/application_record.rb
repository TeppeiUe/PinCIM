class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search_name(value)
    where("name LIKE ?", "%#{sanitize_sql_like(value)}%")
  end
end
