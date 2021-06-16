// 活動種別の登録の有無で表示を変更
$(function(){
  setActivityDetailStatus()
});

function setActivityDetailStatus() {
  let listCount = $('ul.activity_detail_list').children().length;
  if(!listCount) {
    $('p.activity_detail_status').removeClass('d-none');
  } else {
    $('p.activity_detail_status').addClass('d-none');
  }
}