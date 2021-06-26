$(function() {
  $('#customer_belong_name').on('blur', function(){
    if ($('input[name="customer[radio_belong]"]:checked').val() == 'new') {
      let inputValue = $.trim($(this).val());
      belongNameAjax(inputValue);
    }
  });

  $('input[name="customer[radio_belong]"]').on('change', function() {
    let inputName = $('#customer_belong_name');
    let inputValue = inputName.val();
    let errorOutput = $('#belong_name_error');

    if ($(this).val() == 'select') {
      errorOutput.text('');
      inputName.removeClass('is-invalid');
      inputName.removeClass('is-valid');
    } else {
      if (inputValue) {
        belongNameAjax(inputValue);
      }
    }
  });

  function belongNameAjax(name) {
    return $.ajax({
      type: 'GET',
      url: '/customers/registrations/get_belong_name',
      data: { name: name },
      dataType: 'json',
      timeout: 5000
    })
    .done(function(data) {
      let inputName = $('#customer_belong_name');
      let errorOutput = $('#belong_name_error');

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