class ActivityDetailsController < ApplicationController
  def index
    get_activity_ids = params[:activity_ids]
    visit_record = VisitRecord.find(params[:visit_record_id])
    data_base = {
      visit_record_id: visit_record.id,
      user_id: current_user.id,
    }
    activity_details = ActivityDetail.where(data_base)
    activity_ids = activity_details.pluck(:activity_id) # DBに登録済の活動種別配列

    Array(get_activity_ids).each do |activity_id|
      if activity_ids.include?(activity_id.to_i)
        # 取得した活動種別がDBに登録済の場合、DBに登録済の活動種別配列から当IDを削除
        activity_ids.delete(activity_id.to_i)
      else
        # 取得した活動種別がDBに存在しない場合、新規登録
        data_detail = { activity_id: activity_id.to_i }.merge(data_base)
        @activity_detail = ActivityDetail.create(data_detail)
      end
    end

    respond_to do |format|
      if activity_ids.blank?
        format.js { render :create }
      else
        # DBに登録済の活動種別配列にIDが残っていた場合、当IDをDBから削除
        @activity_detail = activity_details.find_by(activity_id: activity_ids).destroy
        format.js { render :destroy }
      end
    end
  end
end
