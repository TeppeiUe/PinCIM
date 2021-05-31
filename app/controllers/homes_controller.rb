class HomesController < ApplicationController
  # callbackでfullpathを読み取る場合、#topではhtmlとjsonの2回読み込みが発生し、
  # jsonのpath?が反映されるため、sessionをそれぞれ明記した。

  def top
    @visit_records = current_user.visit_records.includes([:customer])
    @tasks = Task.where(is_active: true, user_id: current_user)
    session[:privious_url] = "/"
  end

  def map
    @customers = current_user.customers
    session[:privious_url] = "/map"
  end
end
