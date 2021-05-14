class ActivityDetailsController < ApplicationController
  before_action :set_activity_detail_find, only: [:create, :update]
  before_action :set_activity_detail, only: [:update, :destroy]

  def create
    if @activity_detail_find.nil?
      @activity_detail = ActivityDetail.new(params_activity_detail)
      @activity_detail.save
    end
    redirect_to visit_record_path(params[:activity_detail][:visit_record_id])
  end

  def update
    if @activity_detail_find.nil?
      @activity_detail.update(params_activity_detail)
    end
    redirect_to visit_record_path(params[:activity_detail][:visit_record_id])
  end

  def destroy
    @activity_detail.destroy
    redirect_to visit_record_path(@activity_detail.visit_record_id)
  end

  private

  def set_activity_detail
    @activity_detail = ActivityDetail.find(params[:id])
  end

  def set_activity_detail_find
    @activity_detail_find = ActivityDetail.find_by(params_activity_detail)
  end

  def params_activity_detail
    params.require(:activity_detail).permit(:activity_id, :visit_record_id)
  end
end
