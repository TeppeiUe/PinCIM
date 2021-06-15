class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def array2datetime(array)
    if array[0].present?
      if array[1].blank? || array[2].blank?
        array[0]
      else
        "#{array[0]} #{array[1]}:#{array[2]}"
      end
    end
  end

  # time_selectフォームのdefault時間選択を操作するためのメソッド
  # falseの場合、指定した時間を選択することが出来る
  def unset_default_time?(array)
    if array[1].blank? || array[2].blank?
      true
    else
      # 00:00で保存されているデータは時間指定なし
      array[1] == "00" && array[2] == "00"
    end
  end

  def datetime2array(datetime)
    if datetime.nil?
      Array.new(3, nil)
    else
      [
        datetime.to_time.to_s.slice(0, 10),
        datetime.to_time.to_s.slice(11, 2),
        datetime.to_time.to_s.slice(14, 2),
      ]
    end
  end
end
