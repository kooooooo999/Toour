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
        #buttonWrap { position: relative; height: 30px; margin-top: 20px; bottom: 20px }
        #saveButton { }
        #showDate { width: 315px; height: 280px; }
        #datepickerDiv { width: 100%; height: 280px; }
        #chooseDate { position: absolute; right: 20px; }
        #date { width: 160px; height: 25px; display: inline-block; margin-bottom: 10px; }
        .buttonBottom { position: absolute; bottom: 10px; right: 0; width: 150px; }
        #addCourseDateTitle {  }
    </style>
    <script type="text/javascript"
            src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=10cb881534fe9be97e2db4854bde4bf1&libraries=services"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=10cb881534fe9be97e2db4854bde4bf1&libraries=LIBRARY"></script>
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
                <%--<div>
                     <p style="display: inline-block">날짜 : </p>
                    <input type="date" id="date"/>
                </div>--%>
                <div id="courseList"></div>
            </div>

            <div id="buttonWrap">
                <div  id="findButton" class="search_container">
                    <button type="button" class="detail_btn" onclick="addCourse(1)">내 코스</button>
                    <button type="button" class="detail_btn" onclick="findWay()">길찾기</button>
                    <button type="button" id="saveButton" class="detail_btn hide" onclick="addCourse(2)">코스 추가</button>
                </div>
            </div>
        </div>

        <%-- 여행 추가 --%>
        <div id="memberCourse" class="hide" style="position: relative;">
            <div id="addCourseTitle" class="hide">
                <p>여행 제목 : <input type="text" style="width: 100px; height: 30px;" id="courseTitle"/></p>
                <p>여행 설명 : <input type="text" style="width: 150px; height: 150px;" id="courseSummary"/></p>
                <button type="button" id="cancelCourseList"  style="font-size: 12px; position: absolute; right: 65px;" class="buttonRight detail_btn" onclick="addCourse(2)">취소</button>
                <button type="button" id="addCourseList"  style="font-size: 12px;" class="buttonRight detail_btn" onclick="addCourseList()">추가</button>
            </div>
        </div>

        <%-- 날짜별 코스 추가하는 창 --%>
        <div id="addCourseDateTitle" class="hide">
            <p>여행 날짜 : <input type="date" id="date"/></p>
            <p>여행 일차 : <input type="text" style="width: 80px; height: 25px;" id="courseDateTitle" placeholder="N일차"/></p>

            <button type="button" id="cancelCourseDate"  style="font-size: 12px; position: absolute; right: 80px; bottom: 10px;"
                    class="buttonRight detail_btn" onclick="courseDate2()">취소</button>
            <button type="button" id="addCourseDate"  style="font-size: 12px; position: absolute; right: 15px; bottom: 10px;"
                    class="buttonRight detail_btn" onclick="addCourseDate()">저장</button>
        </div>

        <div id="searchBox2" class="left_panel hide">
            <button type="button" id="resultButton" class="closeopen_btn" onclick="closeResults()">&lt;&lt;</button>
            <div id="search_results" class="search_results">
            </div>
        </div>

        <div id="map_container" class="map_container">
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
            position: { my: "left top", at: "left top: 100", of: ${'map_container'} }
        };
        $("#memberCourse").dialog(option);

        let option2 = {
            modal: true,
            autoOpen: false, /*호출되는 즉시 대화상자 표시(기본값: true)*/
            title: "여행 추가",
            resizable: true,
            height:340,
            width:200,
            position: { my: "left top", at: "left top: 100", of: ${'map_container'} }
        };
        $("#addCourseTitle").dialog(option2);

        let option3 = {
            modal: true,
            autoOpen: false, /*호출되는 즉시 대화상자 표시(기본값: true)*/
            title: "여행 추가",
            resizable: true,
            height:200,
            width:278,
            position: { my: "left top", at: "left top", of: ${'map_container'} }
        };
        $("#addCourseDateTitle").dialog(option3);
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

            if (res.trim().length < 1) {
                alert("키워드를 확인해 주세요");
                $("#searchKeyword").val("");
                $("#searchKeyword").focus();
                return;
            }
            console.log(res);
            $("#search_results").html(res);

            $("#searchBox2").show();
        });


    }

    // 코스 DB에서 불러오기
    function addCourse(num) {

        <%-- 1일 때는 '내코스', 2일 때는 '코스 추가' 눌렀을 때 --%>
        let number = num;

        $.ajax({
            url: "Controller?type=searchCourse",
            method: "post",
            data: { number: number }
        }).done(function (res) {
            console.log(res);
            $("#memberCourse").html(res);
        });
        $("#memberCourse").dialog("open");
        $("#addCourseTitle").dialog("close");
    }

    // DB에서 해당 코스에 있는 날짜별 코스 가져오기
    function courseDate(course_idx) {
        console.log(course_idx);
        $.ajax({
            url: "Controller?type=searchCourseDate",
            method: "post",
            data: { course_idx: course_idx, num: 2 }
        }).done(function (res) {
            console.log(res);
            $("#memberCourse").html(res);
        })
    }
    // 여행 날짜 이름 정하는 창에서 취소 버튼 누르면 이전 화면으로 되돌아가기
    function courseDate2() {
        let course_idx = $("#courseidxinput").val();
        console.log(course_idx);
        $.ajax({
            url: "Controller?type=searchCourseDate",
            method: "post",
            data: { course_idx: course_idx, num: 2 }
        }).done(function (res) {
            console.log(res);
            $("#memberCourse").html(res);
        })
        $("#addCourseDateTitle").dialog("close");
        $("#memberCourse").dialog("open");
    }

    // 여행 리스트 창에서 '여행 추가' 버튼 누르면 여행 제목 설정 할 창 띄우기
    function openCourseList() {
        $("#addCourseTitle").dialog("open");
        $("#memberCourse").dialog("close");
    }

    // 여행 제목 정하는 창에서 '추가' 버튼 누르면 DB의 course에 여행 목록 추가
    function addCourseList() {
        let member_idx = $("#member_idx").val().trim();
        let course_name = $("#courseTitle").val().trim();
        let course_summary = $("#courseSummary").val().trim();

        $.ajax({
            url: "Controller?type=addCourseList",
            method: "post",
            data: { member_idx: member_idx, course_name: course_name, course_summary: course_summary }
        }).done(function (res) {
            $("#memberCourse").html(res);
        })

        $("#addCourseTitle").dialog("close");
        $("#memberCourse").dialog("open");
    }

    // 날짜별 여행계획 있는 창에서 추가 버튼 누르면 계획 추가할 수 있는 창 띄우기
    function openDateTitle() {
        $("#date").val("");
        $("#courseDateTitle").val("");
        $("#addCourseDateTitle").dialog("open");
        $("#memberCourse").dialog("close");
    }
    
    // 특정 코스에 세부코스 저장하기 (세부코스 만드는 창에서 저장버튼 눌렀을 때)
    function addCourseDate() {
        let date = $("#date").val();
        let course_idx = $("#courseidxinput").val();
        let date_title = $("#courseDateTitle").val();
        console.log(date);
        console.log(course_idx);
        console.log(date_title);

        $.ajax({
            url: "Controller?type=addCourseDate",
            method: "post",
            data: { date: date, course_idx: course_idx, date_title: date_title, num: 2 }
        }).done(function (res) {
            $("#memberCourse").html(res);
        })

        $("#addCourseDateTitle").dialog("close");
        $("#memberCourse").dialog("open");
    }
    
    // 내코스에서 여행이름 눌렀을 때 날짜별 코스 띄우기
    function myCourseDate(course_idx) {
        $.ajax({
            url: "Controller?type=searchCourseDate",
            method: "post",
            data: { course_idx: course_idx, num: 1 }
        }).done(function (res) {
            console.log(res);
            $("#memberCourse").html(res);
        })
    }

    // 내 코스 지도 코스 리스트에 띄우기
    function showCourseList(courseDate_idx) {

        $.ajax({
            url: "Controller?type=myCourseDay",
            type: "post",
            data: { courseDate_idx: courseDate_idx }
        }).done(function (res) {
            $("#courseList").html(res);
        })

        $("#memberCourse").dialog("close");
    }

    // 코스 아예 삭제(코스, 코스 날짜, 코스 일정)
    function totalDeleteCourse(course_idx) {
        console.log("deleteCourse_idx : " + course_idx)
        $.ajax({
            url: "Controller?type=totalCourseDelete",
            type: "post",
            data: { course_idx: course_idx }
        }).done(function (res) {
            document.location.href = "Controller?type=GoWay";
        })
    }

    // 코스 날짜 삭제(코스 날짜, 코스 일정)
    function deleteCourseDate(courseDate_idx) {
        console.log("deleteCourseDate_idx : " + courseDate_idx)
        $.ajax({
            url: "Controller?type=totalCourseDelete",
            type: "post",
            data: { courseDate_idx: courseDate_idx }
        }).done(function (res) {
            document.location.href = "Controller?type=GoWay";
        })
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

    let cnt123 =0;
    function findWay() { // 길찾기 버튼 누르면 카카오 api에 요청해서 json 받아오는 비동기식 호출
        if(cnt123 >0){
            polyline.setMap(null);
        }
        cnt123++;
        removeMarker();

        $.ajax({
            url: "Controller?type=findWay",
            type: "post",
            contentType: "application/json",
            data: JSON.stringify(coursePoints)
        }).done(function (res) {
            // console.log(res);
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
