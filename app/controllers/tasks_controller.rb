class TasksController < ApplicationController
  def new
    @visit_record = VisitRecord.find(params[:visit_record_id])
    @task = Task.new
  end

  def create
    @task = Task.new(params_task)
    @task.save
    redirect_to visit_record_task_path(@task.visit_record_id, @task.id)
  end

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @visit_record = VisitRecord.find(params[:visit_record_id])
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(params_task)
    redirect_to visit_record_task_path(@task.visit_record_id, @task.id)
  end

  private

  def params_task
    params.
      require(:task).
      permit(
        :visit_record_id,
        :title,
        :content,
        :deadline,
        :is_active,
      )
  end
end
