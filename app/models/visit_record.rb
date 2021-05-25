class VisitRecord < ApplicationRecord
  validates :visit_datetime, presence: true

  belongs_to :customer
  belongs_to :key_person
  belongs_to :belong
  belongs_to :sales_end
  has_many :tasks, dependent: :destroy
  has_many :activity_details, dependent: :destroy
  belongs_to :user

  enum rank: {
    rankA: 0,
    rankB: 1,
    rankC: 2,
  }

  def self.search_period(from, to)
    where("visit_datetime BETWEEN ? AND ?", from, to)
  end

  def self.counting_period(from, to)
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
