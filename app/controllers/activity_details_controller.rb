class ActivityDetailsController < ApplicationController
  before_action :set_activity_detail, only: [:update, :destroy]

  def create
    @activity_detail = ActivityDetail.new(params_activity_detail)
    if @activity_detail.save
      @activities = Activity.all
      render "create"
    else
      render "error"
    end
  end

  def update
    if @activity_detail.update(params_activity_detail)
      @activities = Activity.all
      render "update"
    else
      render "error"
    end
  end

  def destroy
    @activity_detail.destroy
  end

  private

  def set_activity_detail
    @activity_detail = ActivityDetail.find(params[:id])
  end

  def params_activity_detail
    params.require(:activity_detail).permit(:activity_id, :visit_record_id)
  end
end
