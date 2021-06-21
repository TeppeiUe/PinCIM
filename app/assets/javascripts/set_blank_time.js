$(function() {
  setBlankTime();
});

$(document).on('shown.bs.modal',function() {
	setBlankTime();
});


function setBlankTime() {
  let time_select_table = {
    4: '時',
    5: '分',
  };

  let id_select_array = [
    'visit_record_visit_time',
    'visit_record_next_time',
    'task_deadline_time'
  ];

  $.each(id_select_array, function(index, id) {
     $.each(time_select_table, function(val, text) {
      let $setForm = $(`#${id}_${val}i`);
      let $setOption = $(`<option value>${text}</option>`);

      if($setForm.children().first().text() != text) {
        $setForm.prepend($setOption);
      }
    });
  });
}