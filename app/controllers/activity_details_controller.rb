class ActivityDetailsController < ApplicationController
  def create
    @activity_detail = ActivityDetail.new(params_activity_detail)
    @activity_detail.save
    redirect_to visit_record_path(@activity_detail.visit_record_id)
  end

  def update
    @activity_detail = ActivityDetail.find(params[:id])
    @activity_detail.update(params_activity_detail)
    redirect_to visit_record_path(@activity_detail.visit_record_id)
  end

  def destroy
    @activity_detail = ActivityDetail.find(params[:id])
    @activity_detail.destroy
    redirect_to visit_record_path(@activity_detail.visit_record_id)
  end

  private

  def params_activity_detail
    params.require(:activity_detail).permit(:activity_id, :visit_record_id)
  end
end
