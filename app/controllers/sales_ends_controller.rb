class SalesEndsController < ApplicationController
  def index
    @sales_ends = SalesEnd.all
    @sales_end = SalesEnd.new
    @belongs = Belong.all
  end

  def create
    @sales_end = SalesEnd.new(params_sales_end)
    if @sales_end.save
      redirect_to sales_end_path(@sales_end.id)
    else
      @sales_ends = SalesEnd.all
      @belongs = Belong.all
      render "index"
    end
  end

  def show
    @sales_end = SalesEnd.find(params[:id])
  end

  def edit
    @sales_end = SalesEnd.find(params[:id])
    @belongs = Belong.all
  end

  def update
    @sales_end = SalesEnd.find(params[:id])
    if @sales_end.update(params_sales_end)
      redirect_to sales_end_path(@sales_end.id)
    else
      @belongs = Belong.all
      render "edit"
    end
  end

  def search
    how = params[:how]
    value = params[:value]
    @sales_ends = SalesEnd.search_sales_end(how, value)
    @belongs = Belong.all
    render "index"
  end

  private

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
