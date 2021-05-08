class CustomersController < ApplicationController
  def new
    @customer = Customer.new
    @key_people = KeyPerson.all
    @sales_ends = SalesEnd.all
  end

  def create
    @customer = Customer.new(params_customer)
    @customer.save
    redirect_to customers_path
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
    @customer.update(params_customer)
    redirect_to customer_path(@customer.id)
  end

  def search
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
