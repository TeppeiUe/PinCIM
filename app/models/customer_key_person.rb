class CustomerKeyPerson < ApplicationRecord
  belongs_to :customer
  belongs_to :key_person
  belongs_to :user

  validate :start_end_check
  validate :end_period_check, on: :update

  def start_end_check
    unless start_period.nil? || end_period.nil?
      errors.add(:end_period, "が過去日です") unless start_period < end_period
    end
  end

  def end_period_check
    if will_save_change_to_attribute?(:end_period)
      if attribute_in_database(:end_period).nil?
        errors.add(:end_period, "は更新できません(他の現役担当者が必要)") unless check_action_ok?
      end
    end
  end

  def end_period_array
    customer.customer_key_people.pluck(:end_period)
  end

  def check_action_ok?
    end_period_array.count(nil) > 1
  end
end
