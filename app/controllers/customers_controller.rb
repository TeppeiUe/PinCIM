class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]
  before_action :set_ragistration_view, only: [:new, :create]

  def new
    @customer = Customer.new
    @key_people = current_user.key_people
    @sales_ends = current_user.sales_ends
    @belongs = current_user.belongs
    gon.radio_sales_end_select = @radio_sales_end_select
  end

  def create
    @customer = current_user.customers.new(params_customer)

    @customer.transaction do
      # 窓口担当者で新規登録を選択
      if params_key_person[:radio_key_person] == "new"
        @radio_key_person_select = ""
        @radio_key_person_new = "checked"
        @key_person_new_value = params_key_person[:key_person_name]
        key_person = current_user.key_people.create(name: @key_person_new_value)
        @customer.key_person_id = key_person.id
      end

      # 営業担当者で新規登録を選択
      if params_sales_end[:radio_sales_end] == "new"
        @radio_sales_end_select = ""
        @radio_sales_end_new = "checked"
        @sales_end_new_value = params_sales_end[:sales_end_name]
        sales_end = current_user.sales_ends.new(name: @sales_end_new_value)

        # 所属で登録済を選択
        if params_belong[:radio_belong] == "select"
          if params_belong[:belong_id].empty?
            flash.now[:alert_belong] = "所属を選択下さい"
          else
            @selected_belong = params_belong[:belong_id]
            sales_end.belong_id = @selected_belong
          end
        # 所属で新規登録を選択
        else
          @radio_belong_select = ""
          @radio_belong_new = "checked"
          if params_belong[:belong_name].blank?
            flash.now[:alert_belong] = "所属を入力下さい"
          else
            @belong_new_value = params_belong[:belong_name]
            belong = current_user.belongs.create(name: @belong_new_value)
            sales_end.belong_id = belong.id
          end
        end
        sales_end.save
        @customer.sales_end_id = sales_end.id
      end
      @customer.save!
    end
    redirect_to customer_path(@customer.id)

    rescue => e
      @key_people = current_user.key_people
      @sales_ends = current_user.sales_ends
      @belongs = current_user.belongs
      gon.radio_sales_end_select = @radio_sales_end_select
      render "new"
  end

  def index
    @customers = current_user.customers.
      includes([:key_person, sales_end: :belong]).
      page(params[:page]).per(10).order(:address)
  end

  def show
  end

  def edit
    @key_people = current_user.key_people
    @sales_ends = current_user.sales_ends
  end

  def update
    if @customer.update(params_customer)
      @map_status = @customer.saved_change_to_attribute?(:address) ? "change" : "stay"
      render "update"
    else
      @key_people = current_user.key_people
      @sales_ends = current_user.sales_ends
      render "edit"
    end
  end

  def search
    @how = params[:how]
    @value = params[:value]
    @customers = current_user.customers.
      search_customer(@how, @value).
      includes([:key_person, sales_end: :belong]).
      page(params[:page]).per(10)
    render "index"
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
    redirect_to root_path unless @customer.user_id == current_user.id
  end

  def set_ragistration_view
    @radio_key_person_select = "checked"
    @radio_key_person_new = ""
    @radio_sales_end_select = "checked"
    @radio_sales_end_new = ""
    @radio_belong_select = "checked"
    @radio_belong_new = ""
    @selected_belong = false
    @key_person_new_value = ""
    @sales_end_new_value = ""
    @belong_new_value = ""
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
      :note,
    )
  end

  def params_key_person
    params.require(:customer).permit(
      :radio_key_person,
      :key_person_name,
    )
  end

  def params_sales_end
    params.require(:customer).permit(
      :radio_sales_end,
      :sales_end_name,
    )
  end

  def params_belong
    params.require(:customer).permit(
      :radio_belong,
      :belong_id,
      :belong_name,
    )
  end
end
