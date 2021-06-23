class VisitRecordsController < ApplicationController
  before_action :set_visit_record, only: [:show, :edit, :update, :destroy]

  def new
    @visit_record = VisitRecord.new
    set_form_select
    @visit_date = Date.today
    @visit_time_nodefault = true
    @next_time_nodefault = true
  end

  def create
    @visit_date, @visit_time_hour, @visit_time_minute = params_visit_datetime
    @next_date, @next_time_hour, @next_time_minute = params_next_datetime
    @visit_record = current_user.visit_records.new(params_visit_record)

    # datetime型のデータに加工し、それぞれのカラムに追加
    @visit_record.visit_datetime = array2datetime(params_visit_datetime)
    @visit_record.next_datetime = array2datetime(params_next_datetime)

    if @visit_record.save
      redirect_to visit_record_path(@visit_record.id)
    else
      set_form_select
      # time_selectフォームにデータ反映するか判定
      @visit_time_nodefault = unset_default_time?(params_visit_datetime)
      @next_time_nodefault = unset_default_time?(params_next_datetime)
      render "new"
    end
  end

  def index
    @visit_records = current_user.visit_records.
      includes([:customer, activity_details: :activity]).
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
    visit_datetime_array = datetime2array(@visit_record.visit_datetime)
    next_datetime_array = datetime2array(@visit_record.next_datetime)

    # datetime型のデータをdate_fieldとtime_selectで扱える形式に変換
    @visit_date, @visit_time_hour, @visit_time_minute = visit_datetime_array
    @next_date, @next_time_hour, @next_time_minute = next_datetime_array

    # time_selectフォームにデータ反映するか判定
    @visit_time_nodefault = unset_default_time?(visit_datetime_array)
    @next_time_nodefault = unset_default_time?(next_datetime_array)
  end

  def update
    @visit_date, @visit_time_hour, @visit_time_minute = params_visit_datetime
    @next_date, @next_time_hour, @next_time_minute = params_next_datetime
    # datetime型のデータに加工し、それぞれのカラムに追加
    @visit_record.visit_datetime = array2datetime(params_visit_datetime)
    @visit_record.next_datetime = array2datetime(params_next_datetime)

    if @visit_record.update(params_visit_record)
      render "update"
    else
      set_form_select
      # time_selectフォームににデータ反映するか判定
      @visit_time_nodefault = unset_default_time?(params_visit_datetime)
      @next_time_nodefault = unset_default_time?(params_next_datetime)
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
      includes([:customer, activity_details: :activity]).
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
    [
      params[:visit_record][:visit_date],
      params[:visit_record]["visit_time(4i)"],
      params[:visit_record]["visit_time(5i)"],
    ]
  end

  def params_next_datetime
    [
      params[:visit_record][:next_date],
      params[:visit_record]["next_time(4i)"],
      params[:visit_record]["next_time(5i)"],
    ]
  end
end
