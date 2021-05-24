class ActivityDetailsController < ApplicationController
  before_action :set_activity_detail, only: [:update, :destroy]

  def create
    @activity_detail = current_user.activity_details.new(params_activity_detail)
    if @activity_detail.save
      @activities = current_user.activities
      render "create"
    else
      render "error"
    end
  end

  def update
    if @activity_detail.update(params_activity_detail)
      @activities = current_user.activities
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
    @activity_detail = current_user.activity_details.find(params[:id])
  end

  def params_activity_detail
    params.require(:activity_detail).permit(:activity_id, :visit_record_id)
  end
end
