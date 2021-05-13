class ActivityDetail < ApplicationRecord
  validates :activity_id, :visit_record_id, presence: true

  belongs_to :visit_record, inverse_of: :activity_details
  validates_presence_of :visit_record
  belongs_to :activity
end
