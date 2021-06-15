// 検索フォームのプレースホルダーを書き換え
$(function(){
  $(document).on('change', '#how', function() {
    var form_text = $("#how option:selected").text();
    $('#value').attr('placeholder', form_text);
  });
});