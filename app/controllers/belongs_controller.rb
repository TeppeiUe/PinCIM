class BelongsController < ApplicationController
  def index
    @belongs = Belong.all
    @belong = Belong.new
  end

  def create
    @belong = Belong.new(params_belong)
    @belong.save
    redirect_to belongs_path
  end

  def show
    @belong = Belong.find(params[:id])
  end

  def edit
    @belong = Belong.find(params[:id])
  end

  def update
    @belong = Belong.find(params[:id])
    @belong.update(params_belong)
    redirect_to belong_path(@belong.id)
  end

  def search
    @belongs = Belong.search_name(params[:value])
    render "index"
  end

  private

  def params_belong
    params.require(:belong).permit(:name, :address)
  end
end
