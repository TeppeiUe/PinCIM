// クラスにselect2割当
function setJsSelect2() {
  $('.js-select2').select2({
    theme: 'bootstrap'
  });
}

$(function() {
	setJsSelect2();
});

// 読み込んだ後の画面サイズ変更で体裁が崩れるため
window.addEventListener("resize", function() {
	setJsSelect2();
});

// modalが開いた後にイベント発生
$(document).on('shown.bs.modal',function() {
  setJsSelect2();
});