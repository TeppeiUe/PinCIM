$(function () {
  let $mapShow = $('#map_show');
  if ($mapShow.length && $mapShow.attr('data-latitude')) {
    setMapShow();
  }
});

function setMapShow() {
  let $mapShow = $('#map_show');

  let latlng = new google.maps.LatLng(
    $mapShow.attr('data-latitude'),
    $mapShow.attr('data-longitude')
  );

  let options = {
    center: latlng,
    zoom: 15,
  };

  let map = new google.maps.Map(
    document.getElementById("map_show"),
    options
  );

  let marker = new google.maps.Marker({
    position: latlng,
    map: map
  });
}