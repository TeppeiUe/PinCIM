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
    radio_key_person, radio_sales_end, radio_belong = params_radio

    @customer.transaction do
      # 窓口担当者で新規登録を選択
      if radio_key_person == "new"
        @radio_key_person_select = ""
        @radio_key_person_new = "checked"
        @key_person_new_value = params[:customer][:key_person_name]

        key_person = current_user.key_people.create(name: @key_person_new_value)
        flash.now[:alert_key_person] = key_person.errors.full_messages_for(:name).join
        @customer.key_person_id = key_person.id
      end

      # 営業担当者で新規登録を選択
      if radio_sales_end == "new"
        @radio_sales_end_select = ""
        @radio_sales_end_new = "checked"
        @sales_end_new_value = params[:customer][:sales_end_name]

        sales_end = current_user.sales_ends.new(name: @sales_end_new_value)

        # 所属で登録済を選択
        if radio_belong == "select"
          @selected_belong = params[:customer][:belong_id]

          sales_end.belong_id = @selected_belong

        # 所属で新規登録を選択
        else
          @radio_belong_select = ""
          @radio_belong_new = "checked"
          @belong_new_value = params[:customer][:belong_name]

          belong = current_user.belongs.create(name: @belong_new_value)
          flash.now[:alert_belong] = belong.errors.full_messages_for(:name).join
          sales_end.belong_id = belong.id
        end
        sales_end.save
        flash.now[:alert_sales_end] = sales_end.errors.full_messages_for(:name).join
        if radio_belong == "select"
          flash.now[:alert_belong] =
            sales_end.errors.full_messages_for(:belong).join
        end
        @customer.sales_end_id = sales_end.id
      end
      @customer.save!
    end

    # 窓口担当者の担当期間管理に新規登録
    current_user.customer_key_people.create(
      customer_id: @customer.id,
      key_person_id: @customer.key_person_id
    )
    redirect_to customer_path(@customer.id)

    rescue => e
      flash.now[:alert_name] = @customer.errors.full_messages_for(:name).join
      if radio_key_person == "select"
        flash.now[:alert_key_person] =
          @customer.errors.full_messages_for(:key_person).join
      end
      if radio_sales_end == "select"
        flash.now[:alert_sales_end] =
          @customer.errors.full_messages_for(:sales_end).join
      end

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
    @key_people = KeyPerson.where(id: @customer.customer_key_people.pluck(:key_person_id))
    @sales_ends = current_user.sales_ends
  end

  def update
    if @customer.update(params_customer)
      @map_status = @customer.saved_change_to_attribute?(:address) ? "change" : "stay"
      render "update"
    else
      @key_people = KeyPerson.where(id: @customer.customer_key_people.pluck(:key_person_id))
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

  def params_radio
    [
      params[:customer][:radio_key_person],
      params[:customer][:radio_sales_end],
      params[:customer][:radio_belong],
    ]
  end
end
