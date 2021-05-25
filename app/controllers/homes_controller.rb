class HomesController < ApplicationController
  def top
    @visit_records = current_user.visit_records
    @tasks = Task.where(is_active: true, user_id: current_user)
  end

  def map
    @customers = current_user.customers
  end
end
