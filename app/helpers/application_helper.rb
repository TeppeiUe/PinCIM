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
end
