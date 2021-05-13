class VisitRecordsController < ApplicationController
  before_action :set_visit_record, only: [:show, :edit, :update, :destroy]

  def new
    @visit_record = VisitRecord.new
    @visit_record.activity_details.build
    set_form_select
  end

  def create
    @visit_record = VisitRecord.new(params_visit_record)

    # 複数のactivity_detailレコードが一括で保存できなかったため、展開し個別に保存
    # 空で保存しないよう、トランザクション処理とした
    @visit_record.transaction do
      @visit_record.save!
      params[:visit_record][:activity_details_attributes].each do |k, activity_detail|
        activity_detail[:activity_id].each do |id|
          @visit_record.activity_details.create(activity_id: id)
        end
      end
    end
    redirect_to visit_record_path(@visit_record.id)
  rescue => e
    @visit_record.activity_details.build
    set_form_select
    render "new"
  end

  def index
    @visit_records = VisitRecord.all
  end

  def show
  end

  def edit
    set_form_select
  end

  def update
    if @visit_record.update(params_visit_record)
      redirect_to visit_record_path(@visit_record.id)
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
    @visit_records = VisitRecord.search_period(from, to)
    render "index"
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
    @activities = Activity.all
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
        :system,
        :next_datetime,
        :note,
        :rank,
        # TODO: 以下の方法で実装出来るか試す
        # activity_details_attributes: { activity_id: [] },
        # activity_details_attributes: [:activity_id]
      )
  end
end
