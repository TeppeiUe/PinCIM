module ApplicationHelper
  def full_title(page_title)
    base_title = "PinCIM"
    if page_title.empty?
      base_title
    else
      base_title + " | " + page_title
    end
  end

  def def_datetime(datetime)
    if datetime.nil?
      "なし"
    else
      if datetime.hour == 0 && datetime.min == 0
        datetime.strftime("%Y/%m/%d(#{t('date.abbr_day_names')[datetime.wday]})")
      else
        datetime.strftime("%Y/%m/%d(#{t('date.abbr_day_names')[datetime.wday]}) %H:%M")
      end
    end
  end

  def def_date(date)
    date.nil? ? "" : date.strftime("%Y年%m月")
  end

  # simple_formatメソッドではpタグが入って来て扱いにくいため定義した
  def text_format(text)
    if text.nil?
      "なし"
    else
      text.blank? ? "なし" : safe_join(text.split(/\R/), tag(:br))
    end
  end

  def item_format(text)
    text.blank? || text.nil? ? "未登録" : text
  end

  def btn_type(btn_name)
    btn_name.include?("変更") ? "primary" : "success"
  end

  # タスクが実行中である場合緑色の文字
  def status_color(active)
    "text-success" if active
  end

  # タスクが期限切れでかつ実行中である場合赤文字
  def deadline_color(active, deadline)
    unless deadline.nil?
      "text-danger" if active && deadline < Time.now
    end
  end

  def user_system
    current_user.id == 2 ? "#{ENV['SELECT_SYSTEM']}" : "systemA"
  end
end
