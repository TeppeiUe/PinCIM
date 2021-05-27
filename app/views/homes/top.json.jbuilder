json.array!(@visit_records) do |visit_record|
  json.title visit_record.customer.name
  json.start visit_record.visit_datetime
  json.backgroundColor '#8faadc'
  json.borderColor '#8faadc'
  json.url visit_record_path(visit_record.id, format: :html)
end
json.array!(@tasks) do |task|
  json.title task.title
  json.start task.deadline
  json.backgroundColor '#c5e0b4'
  json.borderColor '#c5e0b4'
  json.url visit_record_task_path(task.visit_record_id, task.id, format: :html)
end
