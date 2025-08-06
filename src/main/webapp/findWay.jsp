<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>길찾기 경로 시각화</title>
    <script type="text/javascript"
            src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=10cb881534fe9be97e2db4854bde4bf1&libraries=services"></script>
</head>

<body>
<div id="map" style="width:100%;height:600px;"></div>
<button type="button" onclick="findWay()">길찾기</button>
<div id="test" style="width: 600px; height: 600px;">

</div>

<%
    // 예시 좌표: API 응답에서 가져온 값
    String[] names = {"출발지", "경유지", "도착지"};
    double[] lats = {37.394348634049784, 37.39639094915999, 37.401999820065534}; // 위도
    double[] lngs = {127.11024293202674, 127.11341936045922, 127.10860518470294}; // 경도
%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">
    /*지도 표시 부분*/
    var mapContainer = document.getElementById('map');
    var mapOption = {
        center: new kakao.maps.LatLng(<%= lats[0] %>, <%= lngs[0] %>),
        level: 5
    };
    var map = new kakao.maps.Map(mapContainer, mapOption);

    /*좌표 찍는 부분*/
    <% for (int i = 0; i < lats.length; i++) { %>
    var marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(<%= lats[i] %>, <%= lngs[i] %>),
        map: map
        <%--title: "<%= names[i] %>"--%>
    });

    <% } %>



    function findWay() {
        $.ajax({
            url: "Controller?type=findWay",
            type: "post",
        }).done(function (res) {
            console.log(res);
            $("#test").html(res);
        });
    }

</script>
</body>
</html>
