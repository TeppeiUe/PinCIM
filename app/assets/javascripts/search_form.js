// 検索フォームのプレースホルダーを書き換え
$(function(){
  var select = document.querySelector("#how");

  if(select !== null){
    select.onchange = function() {
      var form_value = select.value;
      var check_form_customer = form_value.indexOf("customer");
      var check_form_sales_end = form_value.indexOf("sales_end");

      if(check_form_customer !== -1){
        if (form_value == "customer_name"){
          $("#value").attr("placeholder", "顧客名");
        } else if(form_value == "customer_address"){
          $("#value").attr("placeholder", "住所");
        }
      } else if(check_form_sales_end !== -1){
        if (form_value == "sales_end_name"){
          $("#value").attr("placeholder", "担当者名");
        } else if(form_value == "sales_end_belong_name"){
          $("#value").attr("placeholder", "所属名");
        }
      }
    };
  }
});