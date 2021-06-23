class Customers::RegistrationsController < ApplicationController
  before_action :set_error_array

  def get_customer_name
    customer = Customer.create(name: params[:name], user_id: current_user.id)
    customer.valid?

    if customer.errors.messages.include?(:name)
      @errors = customer.errors.full_messages_for(:name)
    end

    respond_to do |format|
      format.json { render json: @errors }
    end
  end

  def get_key_person_name
    key_person = KeyPerson.new(name: params[:name], user_id: current_user.id)
    key_person.valid?

    if key_person.errors.messages.include?(:name)
      @errors = key_person.errors.full_messages_for(:name)
    end

    respond_to do |format|
      format.json { render json: @errors }
    end
  end

  def get_sales_end_name
    sales_end = SalesEnd.new(name: params[:name], user_id: current_user.id)
    sales_end.valid?

    if sales_end.errors.messages.include?(:name)
      @errors = sales_end.errors.full_messages_for(:name)
    end

    respond_to do |format|
      format.json { render json: @errors }
    end
  end

  def get_belong_name
    belong = Belong.new(name: params[:name], user_id: current_user.id)
    belong.valid?

    if belong.errors.messages.include?(:name)
      @errors = belong.errors.full_messages_for(:name)
    end

    respond_to do |format|
      format.json { render json: @errors }
    end
  end

  private

  def set_error_array
    @errors = []
  end
end
