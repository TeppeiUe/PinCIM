// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require moment
//= require fullcalendar
//= require rails-ujs
//= require activestorage
// require turbolinks
//= require_tree .

// bootstrapヘッダー固定時のページ開始位置の調節
$(function() {
  var height = $('.navbar').innerHeight();
  $('body').css('padding-top',height);
});

// リダイレクト対策、urlの書き換え
$(function(){
  var path = location.pathname;

  var check_pattern_search = "/search";
  var check_pattern_counting = "/counting";

  var check_path_search = path.lastIndexOf(check_pattern_search);
  var check_path_counting = path.lastIndexOf(check_pattern_counting);

  if(check_path_search !== -1){
    var set_path = path.slice(0, -check_pattern_search.length);
    history.replaceState(null, null, set_path);
  } else if(check_path_counting !== -1){
    var set_path = path.slice(0, -check_pattern_counting.length);
    history.replaceState(null, null, set_path);
  }
});