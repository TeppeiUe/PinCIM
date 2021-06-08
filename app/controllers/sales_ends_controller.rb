class SalesEndsController < ApplicationController
  before_action :set_sales_end_new, only: [:index, :search]
  before_action :set_sales_end, only: [:show, :edit, :update]
  before_action :set_belongs, only: [:index, :edit, :search]

  def index
    @sales_ends = current_user.sales_ends.includes([:belong]).page(params[:page]).per(10)
  end

  def create
    @sales_end = current_user.sales_ends.new(params_sales_end)
    if @sales_end.save
      render "create"
    else
      render "error"
    end
  end

  def show
    @customers = @sales_end.customers
  end

  def edit
  end

  def update
    if @sales_end.update(params_sales_end)
      render "update"
    else
      set_belongs
      render "edit"
    end
  end

  def search
    @how = params[:how]
    @value = params[:value]
    respond_to do |format|
      format.html do
        @sales_ends = current_user.sales_ends.
          search_sales_end(@how, @value).
          includes([:belong]).
          page(params[:page]).per(10)
        render "index"
      end
      format.js do
        @sales_ends = current_user.sales_ends.
          search_sales_end(@how, @value)
        render "search"
      end
    end
  end

  private

  def set_sales_end_new
    @sales_end = SalesEnd.new
  end

  def set_sales_end
    @sales_end = SalesEnd.find(params[:id])
    redirect_to root_path unless @sales_end.user_id == current_user.id
  end

  def set_belongs
    @belongs = current_user.belongs
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
