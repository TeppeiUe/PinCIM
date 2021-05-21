class BelongsController < ApplicationController
  before_action :set_belong_new, only: [:index, :search]
  before_action :set_belong, only: [:show, :edit, :update]

  def index
    @belongs = Belong.page(params[:page]).per(10)
  end

  def create
    @belong = Belong.new(params_belong)
    if @belong.save
      render "create"
    else
      @belongs = Belong.page(params[:page]).per(10)
      render "error"
    end
  end

  def show
    @sales_ends = @belong.sales_ends
  end

  def edit
  end

  def update
    if @belong.update(params_belong)
      render "update"
    else
      render "edit"
    end
  end

  def search
    @belongs = Belong.
      search_name(params[:value]).
      page(params[:page]).per(10)
    render "index"
  end

  private

  def set_belong_new
    @belong = Belong.new
  end

  def set_belong
    @belong = Belong.find(params[:id])
  end

  def params_belong
    params.require(:belong).permit(:name, :address)
  end
end
