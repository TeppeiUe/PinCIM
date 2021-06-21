$(function () {
  let $mapIndex = $('#map_index');

  if ($mapIndex.length) {
    $.ajax({
      type: 'get',
      url: '/map',
      dataType: 'json'
    })
    .done(function (data) {
      let dataCount = data.length;

      if (dataCount) {
        // 表示するマップの中心を計算
        let latSum = 0, longSum = 0;

        for (var i = 0; i < dataCount; i++) {
          latSum = latSum + data[i].latitude;
          longSum = longSum + data[i].longitude;
        }

        let latAve = latSum / dataCount;
        let longAve = longSum / dataCount;

        setMapIndex();

        function setMapIndex() {
          let latlng = new google.maps.LatLng(
            latAve,
            longAve
          );

          let options = {
            center: latlng,
            zoom: 8,
          };

          let map = new google.maps.Map(
            document.getElementById("map_index"),
            options
          );

          let marker = new Array();
          let infoWindow = new Array();

          for (var i = 0; i < dataCount; i++) {
            let taskCount = data[i].task.length;

            // 情報ウィンドウの内容を作成
            let infoText = `
            <table>
              <tr>
                <th>顧客名：</th>
                <td>${data[i].customer}</td>
              </tr>
              <tr>
              <tr>
                <th>導入システム：</th>
                <td>
                  ${data[i].system}
          `;

            if (data[i].visit_datetime) {
              infoText += `
                </td>
              </tr>
              <tr>
                <th>前回訪問日：</th>
                <td>
                  <a href="${data[i].visit_datetime_url}">
                    ${data[i].visit_datetime}
                  </a>
                </td>
              </tr>
              <tr>
                <th>窓口担当者：</th>
                <td>
                  <a href="${data[i].key_person_url}">
                    ${data[i].key_person}
                  </a>
                </td>
              </tr>
              <tr>
                <th>営業担当者：</th>
                <td>
                  <a href="${data[i].sales_end_url}">
                    ${data[i].sales_end}
                  </a>
                </td>
              </tr>
              <tr>
                <th>次回訪問予定日：</th>
                <td>${data[i].next_datetime}</td>
              </tr>
              <tr>
                <th>タスク：</th>
                <td>
            `;

              if (taskCount) {
                for (var j = 0; j < taskCount; j++) {
                  infoText += `
                  <a href="${data[i].task[j].task_url}">
                    ${data[i].task[j].title}
                  </a><br>
                `;
                }
              } else {
                infoText += `
                  なし
              `;
              }
            }

            infoText += `
                </td>
              </tr>
            </table>
          `;

            // マーカーのスタイルを決定
            let iconUrl = `
            https://maps.google.com/mapfiles/ms/micons/${iconColor(i)}-${iconStyle(i)}.png
          `;

            let markerLatLng = new google.maps.LatLng({
              lat: data[i].latitude,
              lng: data[i].longitude
            });

            marker[i] = new google.maps.Marker({
              position: markerLatLng,
              map: map,
              icon: iconUrl
            });

            infoWindow[i] = new google.maps.InfoWindow({
              content: infoText
            });

            markerEvent(i);
          }

          function markerEvent(i) {
            marker[i].addListener('click', function () {
              infoWindow[i].open(map, marker[i]);
            });
          }

          function iconColor(i) {
            if (!data[i].visit_datetime.length) {
              return 'blue';
            } else {
              if (!data[i].task.length) {
                return 'blue';
              } else {
                return 'red';
              }
            }
          }

          function iconStyle(i) {
            let $userSystem = $mapIndex.attr('data-user_system');
            if (data[i].system.indexOf($userSystem) == -1) {
              return 'dot';
            } else {
              return 'pushpin';
            }
          }
        }
      }
    });
  }
});