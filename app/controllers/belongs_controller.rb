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
  end

  def update
  end

  def search
  end

  private

  def params_belong
    params.require(:belong).permit(:name, :address)
  end
end
