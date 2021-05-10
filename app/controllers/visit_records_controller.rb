class VisitRecordsController < ApplicationController
  def new
    @visit_record = VisitRecord.new
    @customers = Customer.all
    @key_people = KeyPerson.all
    @belongs = Belong.all
    @sales_ends = SalesEnd.all
  end

  def create
    @visit_record = VisitRecord.new(params_visit_record)
    @visit_record.save
    redirect_to visit_record_path(@visit_record.id)
  end

  def index
  end

  def show
    @visit_record = VisitRecord.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search
  end

  private

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
      )
  end
end
