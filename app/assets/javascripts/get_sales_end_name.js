$(function() {
  $('#customer_sales_end_name').on('blur', function() {
    if ($('input[name="customer[radio_sales_end]"]:checked').val() == 'new') {
      let inputValue = $.trim($(this).val());
      salesEndNameAjax(inputValue);
    }
  });

  $('input[name="customer[radio_sales_end]"]').on('change', function() {
    let inputName = $('#customer_sales_end_name');
    let inputValue = inputName.val();
    let errorOutputName = $('#sales_end_name_error');
    let errorOutputSelect = $('#sales_end_select_error');

    if ($(this).val() == 'select') {
      errorOutputName.text('');
      inputName.removeClass('is-invalid');
      inputName.removeClass('is-valid');
    } else {
      errorOutputSelect.text('');
      if (inputValue) {
        salesEndNameAjax(inputValue);
      }
    }
  });

  function salesEndNameAjax(name) {
    return $.ajax({
      type: 'GET',
      url: '/customers/registrations/get_sales_end_name',
      data: { name: name },
      dataType: 'json',
      timeout: 5000
    })
    .done(function(data) {
      let inputName = $('#customer_sales_end_name');
      let errorOutputName = $('#sales_end_name_error');

      if (data.length) {
        errorOutputName.text(data[0]);
        inputName.addClass('is-invalid');
        inputName.removeClass('is-valid');
      } else {
        errorOutputName.text('');
        inputName.removeClass('is-invalid');
        inputName.addClass(('is-valid'));
      }
    })
    .fail(function () {
      console.log("通信に失敗しました");
    });
  }
});