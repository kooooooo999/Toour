<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>👋🏻toour</title>
    <style>
        /*body { font-family: sans-serif; margin: 0; padding: 20px; display: flex; justify-content: center; background-color: #f0f2f5; }*/
        .mapContainer { display: flex; gap: 20px; }
        .left_panel { width: 30%; min-width: 300px; background: #fff; padding: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); border-radius: 8px; }
        .map_container { flex-grow: 1; height: 80vh; min-height: 500px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
        #map { width: 100%; height: 100%; }
        .search_container { margin-bottom: 20px; position: relative;}
        .searchKeyword { display: block; width: calc(100% - 22px); padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; }
        #destinationKeyword { width: calc(100% - 22px); padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; }
        .search_results, .selected_places { margin-top: 20px; }
        .search_results h3, .selected_places h3 { margin-top: 0; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .list_item { display: flex; justify-content: space-between; align-items: center; padding: 10px; border-bottom: 1px solid #eee; }
        .list_item:last-child { border-bottom: none; }
        .list_item button { padding: 5px 10px; border: none; background-color: #f7e600; cursor: pointer; border-radius: 4px; }
        .list_item button:hover { background-color: #e0d000; }
        .selected_list_item { display: flex; align-items: center; padding: 10px; border-bottom: 1px solid #eee; }
        .selected_list_item .number { font-weight: bold; font-size: 1.2em; color: #555; width: 25px; text-align: center; }
        .selected_list_item .place-info { flex-grow: 1; margin-left: 10px; }
        #findWayBox { margin: 10px auto; }
        .buttonRight { position: absolute; right: 22px; padding: 2px 7px; margin-top: 5px; }
    </style>
    <script type="text/javascript"
            src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=10cb881534fe9be97e2db4854bde4bf1&libraries=services"></script>
</head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>👋🏻toour</title>
    <link rel="stylesheet" href="<c:url value="/css/style.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
<body>
<c:import url="/common/header.jsp" />
<div id="findWayBox" class="container mapContainer">
    <div id="searchBox" class="left_panel">
        <div class="search_container">
            <h3>출발지</h3>
            <input type="text" class="searchKeyword" id="searchKeyword" placeholder="키워드나 주소를 입력하세요">
            <button type="button" class="buttonRight onclick="placesearch()">검색</button>
        </div>

        <div class="search_container">
            <h3>도착지</h3>
            <input type="text" class="searchKeyword" id="destinationKeyword" placeholder="키워드나 주소를 입력하세요"/>
            <button type="button" class="buttonRight">검색</button>
        </div>

        <div class="search_results">
            <h3>검색 결과</h3>
            <ul id="places_list"></ul>
        </div>

        <div class="selected_places">
            <h3>선택된 코스</h3>
            <ul id="selected_places_list"></ul>
        </div>
    </div>

    <div class="map_container">
        <div id="map" class="map_container"></div>
    </div>
</div>

<%--<div id="map" style="width:800px;height:600px;"></div>--%>
<button type="button" onclick="findWay()">길찾기</button>
<div id="test"></div>

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
        center: new kakao.maps.LatLng(37.556074, 126.9718732),
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
    <c:import url="/common/footer.jsp" />
</body>
</html>
