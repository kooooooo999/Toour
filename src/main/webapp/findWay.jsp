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
        .map_container { flex-grow: 1; width: 500px; height: 80vh; min-height: 500px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); border-radius: 8px; overflow: hidden; }
        #map { width: 100%; height: 100%; }
        .search_container { margin-bottom: 40px; position: relative;}
        .searchKeyword { display: block; width: calc(100%); padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; margin-top: 10px; }
        #destinationKeyword { width: calc(100%); padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; margin-top: 10px; }
        .search_results { margin-top: 5px; }
        .selected_places { margin-top: 50px; display: inline-block}
        .search_results h3, .selected_places h3 { margin-top: 0; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .list_item { display: flex; justify-content: space-between; align-items: center; padding: 10px; border-bottom: 1px solid #eee; }
        .list_item:last-child { border-bottom: none; }
        .list_item button { padding: 5px 10px; border: none; background-color: #f7e600; cursor: pointer; border-radius: 4px; }
        .list_item button:hover { background-color: #e0d000; }
        .selected_list_item { display: flex; align-items: center; padding: 10px; border-bottom: 1px solid #eee; }
        .selected_list_item .number { font-weight: bold; font-size: 1.2em; color: #555; width: 25px; text-align: center; }
        .selected_list_item .place-info { flex-grow: 1; margin-left: 10px; }
        #findWayBox { margin: 10px auto; }
        .buttonRight { position: absolute; right: 0; width: 60px; padding: 3px 10px; margin-top: 5px; }
        #searchBox { width: 300px; padding-top: 26px; position: relative; }
        #searchBox2 { width: 300px; position: relative; }
        .hide { display: none }
        .show { display: block }
        #resultButton { position: absolute; right: 10px; top: 5px; padding: 2px 7px; }
        #resultOpen { position: absolute; right: 10px; top: 5px; padding: 2px 7px; }
        .marginAuto { margin: 0 auto; }
        .marginTop55 { margin-top: 55px; }
        #findButton { width: 260px; height: 30px; margin: auto; position: absolute; bottom: 20px; }
        .detail_btn { background-color: #007bff; border: 0px; color: white; padding: 3px 10px; border-radius: 5px; font-size: 13px; margin-top: 5px; }
        .closeopen_btn { background-color: #eee; border: 0px; color: #555; padding: 3px 10px; border-radius: 5px; font-size: 13px; margin-top: 5px; }
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
<div style="width: 100%;">
    <div id="findWayBox" class="marginAuto container mapContainer">
        <div id="searchBox" class="left_panel">

            <button type="button" id="resultOpen" class="closeopen_btn" onclick="openResult()">&gt;&gt;</button>

            <div class="search_container">
                <h3>어디로 갈까?</h3>
                <hr style="margin-top: 7px;" color="#eee" size="1px" width="100px"/>
                <input type="text" class="searchKeyword" id="searchKeyword" placeholder="키워드나 주소를 입력하세요">
                <button type="button" class="buttonRight detail_btn" onclick="searchplace()">검색</button>
            </div>

            <div class="selected_places">
                <h3>여기로 가야지!</h3>
                <ul id="selected_places_list"></ul>
            </div>

            <div  id="findButton" class="search_container">
                <button type="button" class="buttonRight detail_btn" onclick="findWay()">길찾기</button>
            </div>

        </div>

        <div id="searchBox2" class="left_panel hide">
            <button type="button" id="resultButton" class="closeopen_btn" onclick="closeResults()">&lt;&lt;</button>
            <div class="search_results">
                <h3>검색 결과</h3>
                <ul id="places_list"></ul>
            </div>
        </div>

        <div class="map_container">
            <div id="map"></div>
        </div>
    </div>
</div>

<%--<div id="map" style="width:800px;height:600px;"></div>--%>

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
        center: new kakao.maps.LatLng(37.499294, 127.0331883),
        level: 5
    };
    // 지도 생성
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // vo에 저장된 mapx, mapy 값 얻어내야 함
    <c:set var="vo" value="${requestScope.testvo}"/>

    // 마커가 표시될 위치
    <%--var markerPosition  = new kakao.maps.LatLng(&lt;%&ndash;${vo.}&ndash;%&gt;, 126.570667);--%>

    // 마커를 생성
    var marker = new kakao.maps.Marker();
    var markers=[];
    // 마커가 지도 위에 표시되도록 설정
    // marker.setMap(map);

    // 아래 코드는 지도 위의 마커를 제거하는 코드
    // marker.setMap(null);

    // 장소 검색 객체
    var ps = new kakao.maps.services.Places();

    /*좌표 찍는 부분*/
    <%--<% for (int i = 0; i < lats.length; i++) { %>
    var marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(<%= lats[i] %>, <%= lngs[i] %>),
        map: map
        &lt;%&ndash;title: "<%= names[i] %>"&ndash;%&gt;
    });

    <% } %>--%>

    function findWay() { // 길찾기 버튼 누르면 카카오 api에 요청해서 json 받아오는 비동기식 호출
        $.ajax({
            url: "Controller?type=findWay",
            type: "post",
        }).done(function (res) {
            console.log(res);
            $("#test").html(res);
        });
    }

    function searchplace() {
        let keyword = $("#searchKeyword").val().trim();

        // 키워드로 장소 검색
        ps.keywordSearch(keyword, placesSearchCB);

        // 키워드 검색 완료 시 호출되는 함수
        function placesSearchCB(data, status, pagination) {
            removeMarker();
            if (status === kakao.maps.services.Status.OK) {

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표 추가
                var bounds = new kakao.maps.LatLngBounds();

                for (var i = 0; i < data.length; i++) {
                    displayMarker(data[i]);
                    bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                }

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정
                map.setBounds(bounds);
            }
        }

        // 지도에 검색한 위치에 마커를 표시하는 함수
        function displayMarker(place) {
            // 마커를 생성하고 지도에 표시
                marker = new kakao.maps.Marker({
                map: map,
                position: new kakao.maps.LatLng(place.y, place.x)
            });
            markers.push(marker);

            // 마커에 클릭이벤트를 등록
            kakao.maps.event.addListener(marker, 'click', function() {
                // 마커를 클릭하면 장소명이 인포윈도우에 표출
                infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
                infowindow.open(map, marker);
            });
        }
        $("#searchBox2").show();
    }

    // 검색 결과 창 숨기기
    function closeResults() {
        $("#searchBox2").hide();
    }

    // 검색 결과 창 열기
    function openResult() {
        $("#searchBox2").show();
    }

    // 마커 초기화
    function removeMarker() {
        for ( var i = 0; i < markers.length; i++ ) {
            markers[i].setMap(null);
        }
        markers = [];
    }


</script>
    <c:import url="/common/footer.jsp" />
</body>
</html>
