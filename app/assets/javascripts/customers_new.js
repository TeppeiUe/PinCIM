// 営業担当者で"新規登録"を選択した場合表示
$(function() {
	let $belongField = $('#selected_sales_end_new');

	if(gon.radio_sales_end_select == "checked") {
		$belongField.hide();
	}

	$('[name="customer[radio_sales_end]"]:radio').change(function() {
		if($('#customer_radio_sales_end_new').prop('checked')) {
			$belongField.show();
		} else if($('#customer_radio_sales_end_select').prop('checked')) {
			$belongField.hide();
		}
	});
});