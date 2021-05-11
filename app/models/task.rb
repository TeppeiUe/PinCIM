class Task < ApplicationRecord
  validates :visit_record_id, :title, presence: true

  belongs_to :visit_record
end
