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
//= require select2
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
$(function() {
  let path = location.pathname;

  let check_pattern = [
    '/search',
    '/counting'
  ];

  $.each(check_pattern, function(index, pattern){
    let check_path = path.lastIndexOf(pattern);
    if (check_path !== -1) {
      let replace_path = path.slice(0, -pattern.length);
      history.replaceState(null, null, replace_path);
    }
  });
});