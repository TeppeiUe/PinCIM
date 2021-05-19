class SalesEndsController < ApplicationController
  before_action :set_sales_end_new, only: [:index, :search]
  before_action :set_sales_end, only: [:show, :edit, :update]
  before_action :set_belongs, only: [:index, :edit, :search]

  def index
    @sales_ends = SalesEnd.page(params[:page]).per(10)
  end

  def create
    @sales_end = SalesEnd.new(params_sales_end)
    if @sales_end.save
      redirect_to sales_end_path(@sales_end.id)
    else
      set_belongs
      @sales_ends = SalesEnd.page(params[:page]).per(10)
      render "index"
    end
  end

  def show
    @customers = @sales_end.customers
  end

  def edit
  end

  def update
    if @sales_end.update(params_sales_end)
      redirect_to sales_end_path(@sales_end.id)
    else
      set_belongs
      render "edit"
    end
  end

  def search
    how = params[:how]
    value = params[:value]
    @sales_ends = SalesEnd.
      search_sales_end(how, value).
      page(params[:page]).per(10)
    render "index"
  end

  private

  def set_sales_end_new
    @sales_end = SalesEnd.new
  end

  def set_sales_end
    @sales_end = SalesEnd.find(params[:id])
  end

  def set_belongs
    @belongs = Belong.all
  end

  def params_sales_end
    params.require(:sales_end).permit(
      :name,
      :belong_id,
      :post,
      :telephone_number,
      :note,
    )
  end
end
