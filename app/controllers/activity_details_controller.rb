class ActivityDetailsController < ApplicationController
  def create
    @activity_detail = ActivityDetail.new(params_activity_detail)
    @activity_detail.save
    redirect_to visit_record_path(@activity_detail.visit_record_id)
  end

  def update
  end

  def destroy
  end

  private

  def params_activity_detail
    params.require(:activity_detail).permit(:activity_id, :visit_record_id)
  end
end
