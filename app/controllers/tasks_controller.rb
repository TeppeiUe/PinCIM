class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]

  def new
    set_visit_record
    @task = Task.new
  end

  def create
    @task = Task.new(params_task)
    if @task.save
      redirect_to visit_record_task_path(@task.visit_record_id, @task.id)
    else
      set_visit_record
      render "new"
    end
  end

  def index
    @tasks = Task.all
  end

  def show
  end

  def edit
    set_visit_record
  end

  def update
    if @task.update(params_task)
      redirect_to visit_record_task_path(@task.visit_record_id, @task.id)
    else
      set_visit_record
      render "edit"
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_visit_record
    @visit_record = VisitRecord.find(params[:visit_record_id])
  end

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