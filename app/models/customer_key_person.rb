class CustomerKeyPerson < ApplicationRecord
  belongs_to :customer
  belongs_to :key_person
  belongs_to :user

  validate :start_end_check

  def start_end_check
    unless start_period.nil? || end_period.nil?
      errors.add(:end_period, "が過去日です") unless start_period < end_period
    end
  end

  def end_period_array
    customer.customer_key_people.pluck(:end_period)
  end

  def check_action_ok?
    end_period_array.count(nil) > 1
  end
end
