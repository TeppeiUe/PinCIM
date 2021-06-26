$(function(){
	$('#visit_record_customer_id').on('select2:select', function() {
		$.ajax({
			type: 'GET',
			url: '/visit_records/registrations/get_customer',
			data: { customer_id: $(this).has('option:selected').val() },
			dataType: 'json',
			timeout: 5000
		})
		.done(function(data) {
			$('#visit_record_key_person_id').select2("val", data['key_person_id'].toString());
			$('#visit_record_sales_end_id').select2("val", data['sales_end_id'].toString());
			$('#visit_record_belong_id').select2("val", data['belong_id'].toString());
		})
		.fail(function () {
    	console.log("通信に失敗しました");
		});
  });
});