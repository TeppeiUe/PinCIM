$(function(){
  setBlankTime()
});

$(document).on('shown.bs.modal',function(){
	setBlankTime()
});


function setBlankTime() {
  let time_select_table = {
    4: '時',
    5: '分',
  };

  $.each(time_select_table, function(val, text){
    let setForm = $(`#visit_record_visit_time_${val}i`);
    let setOption = $(`<option value>${text}</option>`);

    if(setForm.children().first().text() != text){
      setForm.prepend(setOption);
    }
  });

  $.each(time_select_table, function(val, text){
    let setForm = $(`#visit_record_next_time_${val}i`);
    let setOption = $(`<option value>${text}</option>`);

    if(setForm.children().first().text() != text){
      setForm.prepend(setOption);
    }
  });
}