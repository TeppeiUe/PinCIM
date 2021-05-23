class VisitRecordsController < ApplicationController
  before_action :set_visit_record, only: [:show, :edit, :update, :destroy]

  def new
    @visit_record = VisitRecord.new
    set_form_select
  end

  def create
    @visit_record = VisitRecord.new(params_visit_record)
    if @visit_record.save
      redirect_to visit_record_path(@visit_record.id)
    else
      set_form_select
      render "new"
    end
  end

  def index
    @visit_records = VisitRecord.page(params[:page]).per(10).order(visit_datetime: :desc)
  end

  def show
    @activity_detail = ActivityDetail.new
    @activities = Activity.all.order(:category)
  end

  def edit
    set_form_select
  end

  def update
    if @visit_record.update(params_visit_record)
      render "update"
    else
      set_form_select
      render "edit"
    end
  end

  def destroy
    @visit_record.destroy
    redirect_to visit_records_path
  end

  def search
    from = params[:from_date]
    to = params[:to_date]
    @visit_records = VisitRecord.
      search_period(from, to).
      page(params[:page]).per(10).
      order(visit_datetime: :desc)
    render "index"
  end

  def counting
    @from = params[:from_date_counting]
    @to = params[:to_date_counting]
    redirect_to visit_records_path if @from.blank? || @to.blank?

    visit_records = VisitRecord.counting_period(@from, @to)

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
  end

  def set_form_select
    @customers = Customer.all
    @key_people = KeyPerson.all
    @belongs = Belong.all
    @sales_ends = SalesEnd.all
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
end
