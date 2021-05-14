class VisitRecord < ApplicationRecord
  validates :customer_id, :key_person_id, :belong_id, :sales_end_id, :visit_datetime, presence: true

  belongs_to :customer
  belongs_to :key_person
  belongs_to :belong
  belongs_to :sales_end
  has_many :tasks
  has_many :activity_details, dependent: :destroy
  # TODO: 以下の方法で実装出来るか試す
  # , inverse_of: :visit_record
  # accepts_nested_attributes_for :activity_details

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

  def self.search_period(from, to)
    VisitRecord.where("visit_datetime BETWEEN ? AND ?", from, to)
  end

  def find_active_tasks
    Task.where(visit_record_id: self.id, is_active: true)
  end
end
