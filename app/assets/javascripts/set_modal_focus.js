// 各モーダルフォームの最初のフォームをオートフォーカス
$(document).on('shown.bs.modal',function(){
	var tag = $('.form-control').get(0).tagName;
	$(`${tag}:visible`).first().focus();
});