// 営業担当者で"新規登録"を選択した場合表示
$(function() {
	let $belongField = $('#selected_sales_end_new');
	let $radioCheck = $('input[name="customer[radio_sales_end]"]:checked');

	belongFieldToggle($radioCheck.val());

	$('input[name="customer[radio_sales_end]"]').change(function() {
		belongFieldToggle($(this).val());
	});

	function belongFieldToggle(value) {
		return (value == 'new') ? $belongField.show() : $belongField.hide();
	}
});