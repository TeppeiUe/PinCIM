// 各モーダルフォームの最初のフォームをオートフォーカス
$(document).on('shown.bs.modal',function(){
	let $formControl = $('.form-control');

	if ($formControl.length) {
		let tag = $formControl.get(0).tagName;
		$(`${tag}:visible`).first().focus();
	}
});