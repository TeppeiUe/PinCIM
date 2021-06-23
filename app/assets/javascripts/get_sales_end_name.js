$(function() {
  $('#customer_sales_end_name').on('blur', function(){
    if ($('input[name="customer[radio_sales_end]"]:checked').val() == 'new') {
      let inputValue = $.trim($(this).val());
      salesEndNameAjax(inputValue);
    }
  });
});

$(function() {
  $('input[name="customer[radio_sales_end]"]').on('change', function() {
    let inputName = $('#customer_sales_end_name');
    let inputValue = inputName.val();
    let errorOutput = $('#sales_end_name_error');

    if ($(this).val() == 'select') {
      errorOutput.text('');
      inputName.removeClass('is-invalid');
      inputName.removeClass('is-valid');
    } else {
      if (inputValue) {
        salesEndNameAjax(inputValue);
      }
    }
  });
});

function salesEndNameAjax(name) {
  return $.ajax({
    type: 'GET',
    url: '/customers/registrations/get_sales_end_name',
    data: { name: name },
    dataType: 'json'
  })
  .done(function(data) {
    let inputName = $('#customer_sales_end_name');
    let errorOutput = $('#sales_end_name_error');

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