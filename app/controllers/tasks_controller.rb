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
  end

  def update
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
      )
  end
end
