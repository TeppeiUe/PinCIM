// 検索フォームのプレースホルダーを書き換え
$(function(){
  $('#how').on('change', function() {
    let form_text = $('option:selected', this).text();
    $('#value').attr('placeholder', form_text);
  });
});