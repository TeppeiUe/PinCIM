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
  link "詳細", visit_record_path(visit_record.id)
  parent :visit_records
end

crumb :visit_records_counting do
	link "集計", counting_visit_records_path
	parent :visit_records
end

crumb :tasks do
  link "タスク", tasks_path
  parent :root
end

crumb :task do |task|
  link "#{task.title}の詳細", visit_record_task_path(task.visit_record_id, task.id)
  parent :tasks
end

crumb :sales_ends do
  link "営業担当者", sales_ends_path
  parent :root
end

crumb :sales_end do |sales_end|
  link "#{sales_end.name}氏の詳細", sales_end_path(sales_end.id)
  parent :sales_ends
end

crumb :key_people do
  link "窓口担当者", key_people_path
  parent :root
end

crumb :key_person do |key_person|
  link "#{key_person.name}氏の詳細", key_person_path(key_person.id)
  parent :key_people
end

crumb :customers do
  link "顧客", customers_path
  parent :root
end

crumb :customer_new do
	link "新規登録", new_customer_path
	parent :customers
end

crumb :customer do |customer|
  link "#{customer.name}の詳細", customer_path(customer.id)
  parent :customers
end

crumb :belongs do
  link "所属", belongs_path
  parent :root
end

crumb :belong do |belong|
  link "#{belong.name}の詳細", belong_path(belong.id)
  parent :belongs
end