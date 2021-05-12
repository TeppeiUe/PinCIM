class HomesController < ApplicationController
  def top
    @visit_records = VisitRecord.all
    @tasks = Task.where(is_active: true)
  end
end
