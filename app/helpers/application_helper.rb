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
    datetime.nil? ? "なし" : datetime.strftime("%Y-%m-%d %H:%M")
  end

  # simple_formatメソッドではpタグが入って来て扱いにくいため定義した
  def def_format(text)
    text.nil? ? "なし" : safe_join(text.split(/\R/), tag(:br))
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
