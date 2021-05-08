class CustomersController < ApplicationController
  def new
    @customer = Customer.new
    @key_people = KeyPerson.all
    @sales_ends = SalesEnd.all
  end

  def create
    @customer = Customer.new(params_customer)
    if @customer.save
      redirect_to customers_path
    else
      @key_people = KeyPerson.all
      @sales_ends = SalesEnd.all
      render "new"
    end
  end

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
    @key_people = KeyPerson.all
    @sales_ends = SalesEnd.all
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(params_customer)
      redirect_to customer_path(@customer.id)
    else
      @key_people = KeyPerson.all
      @sales_ends = SalesEnd.all
      render "edit"
    end
  end

  def search
    how = params[:how]
    value = params[:value]
    @customers = Customer.search_customer(how, value)
    render "index"
  end

  private

  def params_customer
    params.require(:customer).permit(
      :name,
      :address,
      :key_person_id,
      :sales_end_id,
    )
  end
end
