json.array!(@visit_records) do |visit_record|
  json.title visit_record.customer.name
  json.start visit_record.visit_datetime
  json.backgroundColor '#f00'
  json.borderColor '#f00'
  json.url visit_record_path(visit_record.id, format: :html)
end
json.array!(@tasks) do |task|
  json.title task.title
  json.start task.deadline
  json.backgroundColor '#0f0'
  json.borderColor '#0f0'
  json.url visit_record_task_path(task.visit_record_id, task.id, format: :html)
end
