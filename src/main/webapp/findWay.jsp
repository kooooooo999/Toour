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
        .search_results { margin-top: 5px; overflow: hidden; text-overflow: ellipsis; }
        .selected_places { margin-top: 50px; display: inline-block; height: 500px; }
        .search_results h3, .selected_places h3 { margin-top: 0; margin-bottom: 10px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .list_item { display: flex; justify-content: space-between; align-items: center; padding: 10px; border-bottom: 1px solid #eee; }
        .list_item:last-child { border-bottom: none; }
        .list_item button { padding: 5px 10px; border: none; background-color: #f7e600; cursor: pointer; border-radius: 4px; }
        .list_item button:hover { background-color: #e0d000; }
        .selected_list_item { display: flex; align-items: center; padding: 10px; border-bottom: 1px solid #eee; }
        .selected_list_item .number { font-weight: bold; font-size: 1.2em; color: #555; width: 25px; text-align: center; }
        .selected_list_item .place-info { flex-grow: 1; margin-left: 10px; }
        #findWayBox { margin: 10px auto; }
        .buttonRight { display: inline-block; position: absolute; right: 0; width: 60px; padding: 3px 10px; margin-top: 5px; }
        .button2 { display: inline-block; }
        #searchBox { width: 300px; height: 756px; padding-top: 26px; position: relative; }
        #searchBox2 { width: 300px; height: 756px; position: relative; }
        .hide { display: none }
        .show { display: block }
        #resultButton { position: absolute; right: 10px; top: 5px; padding: 2px 7px; }
        #resultOpen { position: absolute; right: 10px; top: 5px; padding: 2px 7px; }
        .marginAuto { margin: 0 auto; }
        .marginTop55 { margin-top: 55px; }
        #findButton { width: max-content; height: 30px; position: absolute; right: 0 }
        .detail_btn { background-color: #007bff; border: 0px; color: white; padding: 3px 10px; border-radius: 5px; font-size: 13px; margin-top: 5px; }
        .closeopen_btn { background-color: #eee; border: 0px; color: #555; padding: 3px 10px; border-radius: 5px; font-size: 13px; margin-top: 5px; }
        #places_list { display: block; width: calc(100%); padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; margin-top: 15px; position: relative; }
        #course { display: block; width: 260px; padding: 10px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; margin-top: 15px; position: relative; }
        #courseList { width: 277.5px; height: 420px; overflow-y: auto; margin-top: 10px; }
        #page { margin: auto; margin-top: 23px; }
        .ellip{ font-weight: bold; display: inline-block; width: 215px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .plusButton {display: inline-block; background-image: url("images/plus.png"); background-size: 16px; width: 16px; height: 16px; border: none; position: absolute; right: 10px; }
        .minusButton {display: inline-block; background-image: url("images/minus.png"); background-size: 16px; width: 16px; height: 16px; border: none; position: absolute; right: 10px; }
        #buttonWrap { position: relative; height: 30px; margin-top: 30px; bottom: 20px }
        #saveButton { }
        #showDate { width: 315px; height: 280px; }
        #datepickerDiv { width: 100%; height: 280px; }
        #chooseDate { position: absolute; right: 20px; }
        #date { width: 200px; height: 25px; display: inline-block; }
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
                <input type="text" class="searchKeyword" id="searchKeyword" placeholder="키워드나 주소를 입력하세요" onkeydown="if(event.key=='Enter') searchplace()">
                <button type="button" class="buttonRight detail_btn" onclick="searchplace()">검색</button>
            </div>

            <div id="selected_places" class="selected_places">
                <h3>여기로 가야지!</h3>
                <div>
                     <p style="display: inline-block">날짜 : </p>
                    <input type="date" id="date"/>
                </div>
                <%--<input type="text" id="testDate"/>
                <button type="button" class="detail_btn buttonRight" id="chooseDate" onclick="showDate()">날짜</button>
                &lt;%&ndash; 사용자가 여행 언제갈지 선택할 수 있는 달력 표시 &ndash;%&gt;
                <div id="showDate" class="hide">
                    <div id="datepickerDiv" class="hide">
                        <div id="datepicker"></div>
                        <button type="button" style="font-size: 11px; display: inline-block" class="hide buttonRight detail_btn" id="saveDate" onclick="chooseDate()">선택</button>
                    </div>
                </div>--%>
                <div id="courseList"></div>
            </div>

            <div id="buttonWrap">
                <div  id="findButton" class="search_container">
                    <button type="button" class="detail_btn" onclick="findWay()">길찾기</button>
                    <button type="button" id="saveButton" class="detail_btn hide" onclick="addCourse(this)">추가</button>
                </div>
            </div>
        </div>

        <dialog id="memberCourse">
            <c:forEach items="${requestScope.course_ar}" var="ar" varStatus="vs">
                <a href="">${ar.course_name}</a>
            </c:forEach>
        </dialog>

        <div id="searchBox2" class="left_panel hide">
            <button type="button" id="resultButton" class="closeopen_btn" onclick="closeResults()">&lt;&lt;</button>
            <div id="search_results" class="search_results">
            </div>
        </div>

        <div class="map_container">
            <div id="map"></div>
        </div>
    </div>
</div>

<div id="test"></div>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script type="text/javascript">
    /*지도 표시 부분*/
    var mapContainer = document.getElementById('map');
    var mapOption = {
        center: new kakao.maps.LatLng(37.499294, 127.0331883),
        level: 4
    };
    // 지도 생성
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 마커가 표시될 위치
    <%--var markerPosition  = new kakao.maps.LatLng(&lt;%&ndash;${vo.}&ndash;%&gt;, 126.570667);--%>

    // 마커가 지도 위에 표시되도록 설정
    // marker.setMap(map);

    // 아래 코드는 지도 위의 마커를 제거하는 코드
    // marker.setMap(null);


    // 마커를 생성
    var marker = new kakao.maps.Marker();
    // 마커들 저장할 배열
    var markers=[];

    // 장소 검색 객체
    var ps = new kakao.maps.services.Places();

    $(function () {
        let option = {
            modal: true,
            autoOpen: false, /*호출되는 즉시 대화상자 표시(기본값: true)*/
            title: "나의 코스",
            resizable: true,
            height:300,
            width:300,
            position: {my: "center",at: "center",of: document.getElementById("#map") }

        };
        $("#memberCourse").dialog(option);
    })
    // 검색어로 장소 찾기
    function searchplace() {

        let keyword = $("#searchKeyword").val().trim();
        if (keyword.length < 1) {
            alert("키워드나 주소를 입력해 주세요")
            $("searchKeyword").focus();
            return;
        }
        removeMarker();

        $.ajax({
            url: "Controller?type=searchResult",
            method: "POST",
            data: {keyword: keyword}
        }).done(function (res){
            $("#search_results").html(res);
        });

        $("#searchBox2").show();
    }

    // 코스 DB에 저장
    function addCourse() {
        console.log($("#date").val());
        $("#memberCourse").dialog("open");
    }

    // 페이지 누르면 해당 페이지로 변경되는 코드
    function paging(cPage) {

        let keyword = $("#searchKeyword").val().trim();

        $.ajax({
            url: "Controller?type=searchResult",
            method: "post",
            data: {keyword: keyword, cPage: cPage}
        }).done(function (res) {
            $("#search_results").html(res);
        });
    }

    // 검색 결과 창에서 + 버튼 누르면 코스 칸으로 넘어가는 함수
    function addList(title, i) {

        let keyword = $("#searchKeyword").val().trim();
        console.log(title);
        console.log(i);

        $.ajax({
            url: "Controller?type=searchResult",
            method: "post",
            data: {keyword: keyword, title: title, index: i}
        }).done(function (res) {
            $("#courseList").html(res);
        });
    }

    // 코스 짜는 창에서 - 버튼 누르면 삭제
    function removeList(title, i) {

        let keyword = $("#searchKeyword").val().trim();
        console.log(title);
        console.log(i);

        $.ajax({
            url: "Controller?type=searchResult",
            method: "post",
            data: {keyword: keyword, removeTitle: title, index: i}
        }).done(function (res) {
            $("#courseList").html(res);
        });

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
    // 달력 창 열기

   /* var appendText = $("#datepicker").datepicker( "option", "appendText" );

    function showDate() {
        $("#showDate").dialog({
            position: {my: "left top",at: "right bottom", of: document.getElementById("chooseDate")}
        });
        $("#datepickerDiv").show();
        $("#datepicker").datepicker();
        $("#saveDate").show();
    }

    // 달력 창에서 날짜 선택
    function chooseDate() {
        console.log(appendText);
        $("#testDate").datepicker({ appendText: "yyyy-mm-dd" });
    }*/

    let cnt12 =0;
    function findWay() { // 길찾기 버튼 누르면 카카오 api에 요청해서 json 받아오는 비동기식 호출
        if(cnt12 >0){
            polyline.setMap(null);
        }
        cnt12++;
        removeMarker();

        $.ajax({
            url: "Controller?type=findWay",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify(coursePoints)
        }).done(function (res) {
            console.log(res);
            $("#test").html(res);
        });

        // 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정
        var i, marker;


        for (i = 0; i < points.length; i++) {

            // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
            marker = addMarker(points[i], i);
            markers.push(marker);

        }
        // 지도 범위 재설정
        map.setBounds(bounds);

        function addMarker(position, idx, title) {
            var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
                imgOptions =  {
                    spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                    spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                    offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                },
                markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                marker = new kakao.maps.Marker({
                    position: position, // 마커의 위치
                    image: markerImage
                });

            marker.setMap(map); // 지도 위에 마커를 표출합니다
            markers.push(marker);  // 배열에 생성된 마커를 추가합니다

            return marker;
        }

    }

</script>
    <c:import url="/common/footer.jsp" />
</body>
</html>
