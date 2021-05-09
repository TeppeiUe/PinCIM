class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all.order(:category)
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(params_activity)
    if @activity.save
      redirect_to activities_path
    else
      @activities = Activity.all
      render "index"
    end
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])
    if @activity.update(params_activity)
      redirect_to activities_path
    else
      render "edit"
    end
  end

  def search
    @activities = Activity.search_name(params[:value]).order(:category)
    @activity = Activity.new
    render "index"
  end

  private

  def params_activity
    params.require(:activity).permit(:name, :category)
  end
end
