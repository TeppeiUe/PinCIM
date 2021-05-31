crumb :root do
  link "トップページ", root_path
end

crumb :visit_records do
  link "訪問記録", visit_records_path
  parent :root
end

crumb :visit_records_new do
	link "新規登録", new_visit_record_path
	parent :visit_records
end

crumb :visit_record do |visit_record|
  link "訪問記録詳細", visit_record_path(visit_record.id)
  parent :visit_records
end

crumb :visit_records_counting do
	link "訪問記録集計", counting_visit_records_path
	parent :visit_records
end

crumb :tasks do
  link "タスク", tasks_path
  parent :root
end

crumb :task do |task|
  link "【タスク】#{task.title}の詳細", visit_record_task_path(task.visit_record_id, task.id)
  parent :tasks
end