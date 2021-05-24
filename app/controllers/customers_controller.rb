class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]

  def new
    @customer = Customer.new
    @key_people = KeyPerson.all
    @sales_ends = SalesEnd.all
    @belongs = Belong.all
    @radio_sales_end_select = "checked"
    @radio_sales_end_new = ""
    @radio_belong_select = "checked"
    @radio_belong_new = ""
    @sales_end_new_value = ""
    @belong_new_value = ""
    gon.radio_sales_end_select = @radio_sales_end_select
  end

  def create
    @customer = Customer.new(name: params[:customer][:name], address: params[:customer][:address])
    @radio_sales_end_select = "checked"
    @radio_sales_end_new = ""
    @radio_belong_select = "checked"
    @radio_belong_new = ""
    @sales_end_new_value = ""
    @belong_new_value = ""

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
      @radio_sales_end_select = ""
      @radio_sales_end_new = "checked"
      @sales_end_new_value = params[:customer][:sales_end_name]
      sales_end = SalesEnd.new(name: @sales_end_new_value)
      if params[:customer][:belong] == "id"
        if params[:customer][:belong_id].empty?
          flash.now[:alert] = "所属を選択下さい"
        else
          sales_end.belong_id = params[:customer][:belong_id]
        end
      else
        @radio_belong_select = ""
        @radio_belong_new = "checked"
        if params[:customer][:belong_name].blank?
          flash.now[:alert] = "所属を入力下さい"
        else
          @belong_new_value = params[:customer][:belong_name]
          belong = Belong.create(name: @belong_new_value)
          sales_end.belong_id = belong.id
        end
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
      gon.radio_sales_end_select = @radio_sales_end_select
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
