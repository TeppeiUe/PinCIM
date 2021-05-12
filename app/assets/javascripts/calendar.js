$(function(){
	$(document).on('turbolinks:load', () => {
	  function eventCalendar() {
      return $('#calendar').fullCalendar({});
      };

    function clearCalendar() {
        $('#calendar').html('');
    };

    $(document).on('turbolinks:load', () => {
      eventCalendar();
    });

    $(document).on('turbolinks:before-cache', clearCalendar);

  	$('#calendar').fullCalendar({
      events: '/',
      // カレンダー表示内容の設定
      header: {
        left: 'month listMonth',
        center: 'title',
        right: 'today prev,next',
      },

      // 日本語変換フォーマット
      titleFormat: 'YYYY年 M月',
      dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
      buttonText: {
        today: '今日',
        month: '月',
        listMonth: 'リスト',
      },
      listDayFormat: 'M月D日',

      businessHours: true,  //休日の色付け
      eventLimit: true, //カレンダー表示量の圧縮
      displayEventTime: false,  //カレンダー上の時間表示設定
      eventTextColor: '#000000',
    });
	});
	function eventCalendar() {
      return $('#calendar').fullCalendar({});
      };

    function clearCalendar() {
        $('#calendar').html('');
    };

    $(document).on('turbolinks:load', () => {
      eventCalendar();
    });

    $(document).on('turbolinks:before-cache', clearCalendar);

  $('#calendar').fullCalendar({
    events: '/',
    // カレンダー表示内容の設定
    header: {
      left: 'month listMonth',
      center: 'title',
      right: 'today prev,next',
    },

    // 日本語変換フォーマット
    titleFormat: 'YYYY年 M月',
    dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
    buttonText: {
      today: '今日',
      month: '月',
      listMonth: 'リスト',
    },
    listDayFormat: 'M月D日',

    businessHours: true,  //休日の色付け
    eventLimit: true, //カレンダー表示量の圧縮
    displayEventTime: false,  //カレンダー上の時間表示設定
    eventTextColor: '#000000',
  });
});

$(function() {
  function eventCalendar() {
      return $('#calendar').fullCalendar({});
      };

    function clearCalendar() {
        $('#calendar').html('');
    };

    $(document).on('turbolinks:load', () => {
      eventCalendar();
    });

    $(document).on('turbolinks:before-cache', clearCalendar);

  $('#calendar').fullCalendar({
    events: '/',
    // カレンダー表示内容の設定
    header: {
      left: 'month listMonth',
      center: 'title',
      right: 'today prev,next',
    },

    // 日本語変換フォーマット
    titleFormat: 'YYYY年 M月',
    dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
    buttonText: {
      today: '今日',
      month: '月',
      listMonth: 'リスト',
    },
    listDayFormat: 'M月D日',

    businessHours: true,  //休日の色付け
    eventLimit: true, //カレンダー表示量の圧縮
    displayEventTime: false,  //カレンダー上の時間表示設定
    eventTextColor: '#000000',
  });
});