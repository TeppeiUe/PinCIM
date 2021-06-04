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
    なし: 0,
    rankA: 1,
    rankB: 2,
    rankC: 3,
  }

  def self.search_period(from, to)
    # rubyではJST、DBではUTCで日時を扱っているため、所望のデータを得るためには9時間引く
    # 関数化したいが、出来なかったため一旦保留
    from = from.to_datetime - Rational("9/24") if from.present?
    to = to.to_datetime - Rational("9/24") if to.present?

    where("visit_datetime BETWEEN ? AND ?", from, to)
  end

  def self.counting_period(from, to)
    # rubyではJST、DBではUTCで日時を扱っているため、所望のデータを得るためには9時間引く
    # 関数化したいが、出来なかったため一旦保留
    from = from.to_datetime - Rational("9/24") if from.present?
    to = to.to_datetime - Rational("9/24") if to.present?

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
