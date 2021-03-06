class Task < ApplicationRecord
  validates :visit_record_id, :title, presence: true

  belongs_to :visit_record
  belongs_to :user

  def status
    is_active? ? "実行中" : "完了"
  end
end
