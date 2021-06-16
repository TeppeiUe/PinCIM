class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    set_visit_record
    @task = Task.new
    @deadline_time_nodefault = true
  end

  def create
    @deadline_date, @deadline_time_hour, @deadline_time_minute = params_deadline
    @task = current_user.tasks.new(params_task)
    # datetime型のデータに加工しdeadlimeカラムに追加
    @task.deadline = array2datetime(params_deadline)

    if @task.save
      render "create"
    else
      set_visit_record
      # time_selectフォームにデータ反映するか判定
      @deadline_time_nodefault = unset_default_time?(params_deadline)
      render "new"
    end
  end

  def index
    @tasks = current_user.tasks.
      includes([:visit_record]).
      page(params[:page]).per(10).
      order(deadline: :desc)
  end

  def show
    session[:task_show_view] = request.fullpath.include?(".html") ? "html" : "js"
  end

  def edit
    set_visit_record
    deadline_datetime_array = datetime2array(@task.deadline)

    @deadline_date, @deadline_time_hour, @deadline_time_minute = deadline_datetime_array
    # time_selectフォームにデータ反映するか判定
    @deadline_time_nodefault = unset_default_time?(deadline_datetime_array)
  end

  def update
    @deadline_date, @deadline_time_hour, @deadline_time_minute = params_deadline
    # datetime型のデータに加工しdeadlimeカラムに追加
    @task.deadline = array2datetime(params_deadline)

    if @task.update(params_task)
      @render_page = session[:task_show_view]
      render "update"
    else
      set_visit_record
      # time_selectフォームににデータ反映するか判定
      @deadline_time_nodefault = unset_default_time?(params_deadline)
      render "edit"
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to session[:privious_url] }
      format.js { render "destroy" }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
    redirect_to root_path unless @task.user_id == current_user.id
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
        :is_active,
      )
  end

  def params_deadline
    [
      params[:task][:deadline_date],
      params[:task]["deadline_time(4i)"],
      params[:task]["deadline_time(5i)"],
    ]
  end
end
