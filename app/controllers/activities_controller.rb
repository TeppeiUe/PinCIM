class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(params_activity)
    @activity.save
    redirect_to activities_path
  end

  def edit
  end

  def update
  end

  def search
  end

  private

  def params_activity
    params.require(:activity).permit(:name).
      merge(category: params[:activity][:category].to_i)
  end
end
