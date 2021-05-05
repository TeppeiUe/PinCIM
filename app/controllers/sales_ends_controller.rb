class SalesEndsController < ApplicationController
  def index
    @sales_ends = SalesEnd.all
    @sales_end = SalesEnd.new
    @belongs = Belong.all
  end

  def create
    @sales_end = SalesEnd.new(params_sales_end)
    @sales_end.save
    redirect_to sales_ends_path
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
    @sales_end.update(params_sales_end)
    redirect_to sales_end_path(@sales_end.id)
  end

  def search
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
