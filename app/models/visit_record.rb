class VisitRecord < ApplicationRecord
  validates :customer_id, :key_person_id, :belong_id, :sales_end_id, :visit_datetime, presence: true

  belongs_to :customer
  belongs_to :key_person
  belongs_to :belong
  belongs_to :sales_end

  has_many :activity_detail, dependent: :destroy

  enum system: {
    systemA: 0,
    systemB: 1,
    systemC: 2,
  }

  enum rank: {
    rankA: 0,
    rankB: 1,
    rankC: 2,
  }
end
