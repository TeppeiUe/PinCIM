class BelongsController < ApplicationController
  before_action :set_belong_new, only: [:index, :search]
  before_action :set_belongs, only: [:index, :create]
  before_action :set_belong, only: [:show, :edit, :update]

  def index
  end

  def create
    @belong = Belong.new(params_belong)
    if @belong.save
      redirect_to belongs_path
    else
      render "index"
    end
  end

  def show
    @sales_ends = @belong.sales_ends
  end

  def edit
  end

  def update
    if @belong.update(params_belong)
      redirect_to belong_path(@belong.id)
    else
      render "edit"
    end
  end

  def search
    @belongs = Belong.search_name(params[:value])
    render "index"
  end

  private

  def set_belong_new
    @belong = Belong.new
  end

  def set_belongs
    @belongs = Belong.all
  end

  def set_belong
    @belong = Belong.find(params[:id])
  end

  def params_belong
    params.require(:belong).permit(:name, :address)
  end
end
