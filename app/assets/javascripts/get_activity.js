$(function() {
  $('#activity_detail_activity_id').on('change', function() {
    let path = location.pathname;
    let pathShow = path.replace(/[^0-9]/g, '');

    $.ajax({
			type: 'GET',
			url: `/visit_records/${pathShow}/activity_details`,
			data: { activity_ids: $(this).val() },
		});
  });
})