class ActivitiesController < ApplicationController
  before_action :set_activity_new, only: [:index, :search]
  before_action :set_activity, only: [:edit, :update]

  def index
    @activities = Activity.all.order(:category)
  end

  def create
    @activity = Activity.new(params_activity)
    if @activity.save
      render "create"
    else
      @activities = Activity.all
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
    @activities = Activity.search_name(@value).order(:category)
    render "index"
  end

  private

  def set_activity_new
    @activity = Activity.new
  end

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def params_activity
    params.require(:activity).permit(:name, :category)
  end
end
