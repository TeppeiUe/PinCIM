$(function() {
  $('#customer_key_person_name').on('blur', function(){
    if ($('input[name="customer[radio_key_person]"]:checked').val() == 'new') {
      let inputValue = $.trim($(this).val());
      keyPersonNameAjax(inputValue);
    }
  });

  $('input[name="customer[radio_key_person]"]').on('change', function() {
    let inputName = $('#customer_key_person_name');
    let inputValue = inputName.val();
    let errorOutput = $('#key_person_name_error');

    if ($(this).val() == 'select') {
      errorOutput.text('');
      inputName.removeClass('is-invalid');
      inputName.removeClass('is-valid');
    } else {
      if (inputValue) {
        keyPersonNameAjax(inputValue);
      }
    }
  });

  function keyPersonNameAjax(name) {
    return $.ajax({
      type: 'GET',
      url: '/customers/registrations/get_key_person_name',
      data: { name: name },
      dataType: 'json',
      timeout: 5000
    })
    .done(function(data) {
      let inputName = $('#customer_key_person_name');
      let errorOutput = $('#key_person_name_error');

      if (data.length) {
        errorOutput.text(data[0]);
        inputName.addClass('is-invalid');
        inputName.removeClass('is-valid');
      } else {
        errorOutput.text('');
        inputName.removeClass('is-invalid');
        inputName.addClass(('is-valid'));
      }
    })
    .fail(function () {
      console.log("通信に失敗しました");
    });
  }
});