$(function() {
  $('#customer_name').on('blur', function(){
    let inputValue = $.trim($(this).val());

    $.ajax({
      type: 'GET',
      url: '/customers/registrations/get_customer_name',
      data: { name: inputValue },
      dataType: 'json',
      timeout: 5000
    })
    .done(function (data) {
      let errorOutput = $('#customer_name_error');
      let inputName = $('#customer_name');

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
  });
});