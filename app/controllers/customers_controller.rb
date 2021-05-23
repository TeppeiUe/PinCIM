class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]

  def new
    @customer = Customer.new
    @key_people = KeyPerson.all
    @sales_ends = SalesEnd.all
    @belongs = Belong.all
  end

  def create
    @customer = Customer.new(name: params[:customer][:name], address: params[:customer][:address])

    # 窓口担当者の選択
    if params[:customer][:key_person] == "id"
      @customer.key_person_id = params[:customer][:key_person_id]
    else
      key_person = KeyPerson.create(name: params[:customer][:key_person_name])
      @customer.key_person_id = key_person.id
    end

    # 営業担当者の選択("新規登録"を選択した場合、所属の処理を実行)
    if params[:customer][:sales_end] == "id"
      @customer.sales_end_id = params[:customer][:sales_end_id]
    else
      sales_end = SalesEnd.new(name: params[:customer][:sales_end_name])
      if params[:customer][:belong] == "id"
        sales_end.belong_id = params[:customer][:belong_id]
      else
        belong = Belong.create(name: params[:customer][:belong_name])
        sales_end.belong_id = belong.id
      end
      sales_end.save
      @customer.sales_end_id = sales_end.id
    end

    if @customer.save
      redirect_to customer_path(@customer.id)
    else
      @key_people = KeyPerson.all
      @sales_ends = SalesEnd.all
      @belongs = Belong.all
      render "new"
    end
  end

  def index
    @customers = Customer.page(params[:page]).per(10).order(:address)
  end

  def show
  end

  def edit
    @key_people = KeyPerson.all
    @sales_ends = SalesEnd.all
  end

  def update
    if @customer.update(params_customer)
      @map_status = @customer.saved_change_to_attribute?(:address) ? "change" : "stay"
      render "update"
    else
      @key_people = KeyPerson.all
      @sales_ends = SalesEnd.all
      render "edit"
    end
  end

  def search
    @how = params[:how]
    @value = params[:value]
    @customers = Customer.
      search_customer(@how, @value).
      page(params[:page]).per(10)
    render "index"
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def params_customer
    params.require(:customer).permit(
      :name,
      :address,
      :key_person_id,
      :sales_end_id,
      :latitude,
      :longitude,
      :system,
    )
  end
end
