crumb :root do
  link "Home", root_path
end

crumb :visit_records do
  link "訪問記録一覧", visit_records_path
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