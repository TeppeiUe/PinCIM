class VisitRecordsController < ApplicationController
  before_action :set_visit_record, only: [:show, :edit, :update, :destroy]

  def new
    @visit_record = VisitRecord.new
    set_form_select
    @visit_time_nodefault = true
    @next_time_nodefault = true
  end

  def create
    @visit_date = params_visit_datetime[:visit_date]
    @visit_time_hour = params_visit_datetime["visit_time(4i)"]
    @visit_time_minute = params_visit_datetime["visit_time(5i)"]

    @next_date = params_next_datetime[:next_date]
    @next_time_hour = params_next_datetime["next_time(4i)"]
    @next_time_minute = params_next_datetime["next_time(5i)"]

    @visit_record = current_user.visit_records.new(params_visit_record)

    # datetime型のデータに加工
    @visit_record.visit_datetime = datetime_join(@visit_date, @visit_time_hour, @visit_time_minute)
    @visit_record.next_datetime = datetime_join(@next_date, @next_time_hour, @next_time_minute)

    if @visit_record.save
      redirect_to visit_record_path(@visit_record.id)
    else
      set_form_select
      # time_selectフォームににデータ反映するか判定
      @visit_time_nodefault = time_select_nodefault(@visit_time_hour, @visit_time_minute)
      @next_time_nodefault = time_select_nodefault(@next_time_hour, @next_time_minute)
      render "new"
    end
  end

  def index
    @visit_records = current_user.visit_records.
      page(params[:page]).per(10).
      order(visit_datetime: :desc)
    session[:privious_url] = request.fullpath
  end

  def show
    @activity_detail = ActivityDetail.new
    @activities = current_user.activities.order(:category)
  end

  def edit
    set_form_select
    visit_datetime = @visit_record.visit_datetime
    next_datetime = @visit_record.next_datetime

    # datetime型のデータをtime型やdate型に変換
    @visit_date = datetime_division(visit_datetime, "datetime")
    @visit_time_hour = datetime_division(visit_datetime, "time_hour")
    @visit_time_minute = datetime_division(visit_datetime, "time_minute")

    @next_date = datetime_division(next_datetime, "datetime")
    @next_time_hour = datetime_division(next_datetime, "time_hour")
    @next_time_minute = datetime_division(next_datetime, "time_minute")

    # time_selectフォームににデータ反映するか判定
    @visit_time_nodefault = time_select_nodefault(@visit_time_hour, @visit_time_minute)
    @next_time_nodefault = time_select_nodefault(@next_time_hour, @next_time_minute)
  end

  def update
    @visit_date = params_visit_datetime[:visit_date]
    @visit_time_hour = params_visit_datetime["visit_time(4i)"]
    @visit_time_minute = params_visit_datetime["visit_time(5i)"]

    @next_date = params_next_datetime[:next_date]
    @next_time_hour = params_next_datetime["next_time(4i)"]
    @next_time_minute = params_next_datetime["next_time(5i)"]

    # datetime型のデータに加工
    @visit_record.visit_datetime = datetime_join(@visit_date, @visit_time_hour, @visit_time_minute)
    @visit_record.next_datetime = datetime_join(@next_date, @next_time_hour, @next_time_minute)

    if @visit_record.update(params_visit_record)
      render "update"
    else
      set_form_select
      # time_selectフォームににデータ反映するか判定
      @visit_time_nodefault = time_select_nodefault(@visit_time_hour, @visit_time_minute)
      @next_time_nodefault = time_select_nodefault(@next_time_hour, @next_time_minute)
      render "edit"
    end
  end

  def destroy
    @visit_record.destroy
    redirect_to session[:privious_url]
  end

  def search
    @from = params[:from_date]
    @to = params[:to_date]
    @visit_records = current_user.visit_records.
      search_period(@from, @to).
      page(params[:page]).per(10).
      order(visit_datetime: :desc)
    render "index"
  end

  def counting
    @from = params[:from_date_counting]
    @to = params[:to_date_counting]
    redirect_to visit_records_path, alert: "期間を選択して下さい" if @from.blank? || @to.blank?

    visit_records = current_user.visit_records.counting_period(@from, @to)

    @rows = []
    @columns = []
    # テーブルの行と列名を取得
    visit_records.each do |k, v|
      @rows << k[0] unless @rows.include?(k[0])
      @columns << k[1] unless @columns.include?(k[1])
    end
    # テーブル(多次元配列)のインスタンスにデータを格納
    @table = Array.new(@rows.length).map { Array.new(@columns.length) }
    visit_records.each do |k, v|
      @table[@rows.index(k[0])][@columns.index(k[1])] = v
    end
    # 行集計用のインスタンス
    @sums = Array.new(@columns.length, 0)
  end

  private

  def set_visit_record
    @visit_record = VisitRecord.find(params[:id])
    redirect_to root_path unless @visit_record.user_id == current_user.id
  end

  def set_form_select
    @customers = current_user.customers
    @key_people = current_user.key_people
    @belongs = current_user.belongs
    @sales_ends = current_user.sales_ends
  end

  def params_visit_record
    params.
      require(:visit_record).
      permit(
        :customer_id,
        :key_person_id,
        :belong_id,
        :sales_end_id,
        :visit_datetime,
        :next_datetime,
        :note,
        :rank,
      )
  end

  def params_visit_datetime
    params.require(:visit_record).permit(:visit_date, "visit_time(4i)", "visit_time(5i)")
  end

  def params_next_datetime
    params.require(:visit_record).permit(:next_date, "next_time(4i)", "next_time(5i)")
  end
end
