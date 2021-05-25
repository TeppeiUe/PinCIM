class ActivityDetail < ApplicationRecord
  validates :activity_id, uniqueness: { scope: :visit_record_id }

  belongs_to :visit_record
  belongs_to :activity
  belongs_to :user
end
