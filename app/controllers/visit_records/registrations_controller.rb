class VisitRecords::RegistrationsController < ApplicationController
  def get_customer
    @customer = Customer.find(params[:customer_id])

    respond_to do |format|
      format.json { render "visit_records/get_customer" }
    end
  end
end
