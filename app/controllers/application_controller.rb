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

  # time_selectフォームのdefaultを操作するためのメソッド
  # 時間範囲が8-22であるため、defaultを指定しなければ予期せぬ結果が生じる
  def time_select_nodefault(hour, minute)
    if hour.nil? || minute.nil?
      true
    else
      hour == "00" && minute == "00"
    end
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
