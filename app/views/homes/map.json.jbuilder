json.array!(@customers) do |customer|
  json.customer customer.name
  json.system customer.system

  json.latitude customer.latitude
  json.longitude customer.longitude

  visit_record = customer.latest_visit_record

  unless visit_record.nil?
    json.visit_datetime def_datetime(visit_record.visit_datetime)
    json.visit_datetime_url visit_record_path(visit_record.id)

    json.key_person visit_record.key_person.name
    json.key_person_url key_person_path(visit_record.key_person_id)

    json.sales_end visit_record.sales_end.name
    json.sales_end_url sales_end_path(visit_record.sales_end_id)

    json.next_datetime def_datetime(visit_record.next_datetime)

    active_tasks = visit_record.find_active_tasks

    json.task do
      json.array!(active_tasks) do |active_task|
        json.title active_task.title
        json.task_url visit_record_task_path(visit_record.id, active_task.id, format: :html)
      end
    end
  else
    json.visit_datetime ''
    json.task do
      json.array!
    end
  end
end