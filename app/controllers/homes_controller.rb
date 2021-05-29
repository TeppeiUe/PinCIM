class HomesController < ApplicationController
  after_action :save_previous_url

  def top
    @visit_records = current_user.visit_records
    @tasks = Task.where(is_active: true, user_id: current_user)
  end

  def map
    @customers = current_user.customers
  end

  private

  def save_previous_url
    session[:privious_url] = URI(request.referer || '').path
  end
end
