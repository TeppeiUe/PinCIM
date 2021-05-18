class VisitRecord < ApplicationRecord
  validates :customer_id, :key_person_id, :belong_id, :sales_end_id, :visit_datetime, presence: true

  belongs_to :customer
  belongs_to :key_person
  belongs_to :belong
  belongs_to :sales_end
  has_many :tasks, dependent: :destroy
  has_many :activity_details, dependent: :destroy
  # TODO: 以下の方法で実装出来るか試す
  # , inverse_of: :visit_record
  # accepts_nested_attributes_for :activity_details

  enum rank: {
    rankA: 0,
    rankB: 1,
    rankC: 2,
  }

  def self.search_period(from, to)
    VisitRecord.where("visit_datetime BETWEEN ? AND ?", from, to)
  end

  def self.counting_period(from, to)
    VisitRecord.
      search_period(from, to).
      joins(:belong, activity_details: :activity).
      group("belongs.name").
      group("activities.name").
      order("activities.category").count
  end

  def find_active_tasks
    tasks.where(is_active: true)
  end
end
