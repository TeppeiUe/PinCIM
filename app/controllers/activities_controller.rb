class ActivitiesController < ApplicationController
  before_action :set_activity_new, only: [:index, :search]
  before_action :set_activity, only: [:edit, :update]

  def index
    @activities = current_user.activities.order(:category)
  end

  def create
    @activity = current_user.activities.new(params_activity)
    if @activity.save
      render "create"
    else
      @activities = current_user.activities
      render "error"
    end
  end

  def edit
  end

  def update
    if @activity.update(params_activity)
      render "update"
    else
      render "edit"
    end
  end

  def search
    @value = params[:value]
    @activities = current_user.activities.search_name(@value).order(:category)
    render "index"
  end

  private

  def set_activity_new
    @activity = Activity.new
  end

  def set_activity
    @activity = current_user.activities.find(params[:id])
  end

  def params_activity
    params.require(:activity).permit(:name, :category)
  end
end
