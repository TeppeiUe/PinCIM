// 営業担当者で"新規登録"を選択した場合表示
$(function(){
	if(gon.radio_sales_end_select == "checked"){
		$('#selected_sales_end_name').hide();
	}

	$('[name="customer[sales_end]"]:radio').change(function(){
		if($('#customer_sales_end_name').prop('checked')){
			$('#selected_sales_end_name').show();
	} else if($('#customer_sales_end_id').prop('checked')){
			$('#selected_sales_end_name').hide();
	}
	});
});