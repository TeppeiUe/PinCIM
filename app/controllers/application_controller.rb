class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def datetime_join(date, hour, minute)
    unless date.nil?
      if hour.blank? || minute.blank?
        date
      else
        "#{date} #{hour}:#{minute}"
      end
    end
  end

  def time_select_nodefault(hour, minute)
    hour.blank? && minute.blank? ? true : false
  end

  def datetime_division(datetime, which)
    unless datetime.nil?
      if which == "datetime"
        datetime.to_time.to_s.slice(0, 10)
      elsif which == "time_hour"
        datetime.to_time.to_s.slice(11, 2)
      elsif which == "time_minute"
        datetime.to_time.to_s.slice(14, 2)
      end
    end
  end
end
