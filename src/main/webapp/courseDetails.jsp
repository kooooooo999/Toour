<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>

<html>
<head>
    <script type="text/javascript"
            src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=10cb881534fe9be97e2db4854bde4bf1&libraries=services"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>👋🏻toour</title>
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/style.css" />">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        /* 뒤로가기 버튼 스타일 */
        .back-button {
            position: fixed; /* 👈 스크롤에 상관없이 화면에 고정 */
            bottom: 20px; /* 👈 화면 아래쪽에서 20px 떨어진 위치 */
            left: 20px; /* 👈 화면 왼쪽에서 20px 떨어진 위치 */
            z-index: 1000; /* 다른 요소보다 위에 표시 */

            /* 버튼 디자인 */
            background-color: #337ab7;
            color: white;
            border-radius: 50%; /* 원형 모양 */
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s;
            text-decoration: none; /* 밑줄 제거 */
        }

        .back-button:hover {
            background-color: #286090;
        }

        .courseItems {
            display: flex;
            flex-direction: column; /* 자식 요소들을 수직으로 정렬 */
            align-items: center; /* 수평 중앙 정렬 */
            margin-bottom: 30px; /* 아이템 간 간격 추가 */
        }

        .courseImgs {
            width: 100%;
            height: 100%;
            overflow: hidden; /* 이미지가 컨테이너를 벗어나는 부분을 숨김 */
            display: flex; /* 이미지를 중앙 정렬하기 위해 추가 */
            justify-content: center;
            align-items: center;
        }

        .course-image {
            width: 800px;
            height: 600px;
            object-fit: cover; /* 이미지가 컨테이너를 채우도록 확대/축소 */
        }

        .courseText_1 {
            text-align: center;
            padding: 10px 20px;
        }

        .courseText_2 {
            text-align: center;
            padding: 10px 20px;
            margin-top: -100px;
        }

        /* 이미지가 없을 때의 텍스트 스타일 */
        .emptyText {
            width: 100%;
            height: 100%;
            background-color: #f0f0f0; /* 배경색 */
            color: #888; /* 텍스트 색상 */
            font-size: 24px;
            font-weight: bold;
            display: flex; /* Flexbox를 사용하여 내부 요소를 정렬 */
            justify-content: center; /* 가로 중앙 정렬 */
            align-items: center; /* 세로 중앙 정렬 */
        }

        /* 상세 정보를 감싸는 부모 컨테이너에 적용 */
        #detailsInfo {
            display: flex;
            justify-content: center; /* ul을 가로 중앙으로 정렬 */
            width: 100%;
            padding: 20px 20px;
        }

        /* 상세 정보 목록 ul에 적용 */
        #detailsInfo ul {
            width: 850px; /* 지도와 동일한 너비로 설정하여 정렬 맞추기 */
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            padding: 0;
            list-style-type: none;
            justify-content: center;
        }

        /* 상세 정보 목록 li에 적용 */
        #detailsInfo li {
            width: calc(100% / 3 - 20px * 2 / 3);
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding-left: 70px;
        }

        /* 숙박정보 섹션 제목의 여백을 줄입니다. */
        h3.infoText {
            margin-top: 15px; /* 위쪽 여백을 줄임 */
            margin-bottom: 5px; /* 아래쪽 여백을 줄임 */
            /* 다른 스타일은 유지 */
        }

        /* 구분선의 여백을 줄입니다. */
        .lineDetails {
            margin-top: 5px;
            margin-bottom: 15px; /* 아래쪽 여백을 줄임 */
            /* 다른 스타일은 유지 */
        }

        .courseGrid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px;
        }

        .courseItem {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        /* 이미지를 담는 div의 크기를 고정 */
        .courseImages, .courseImgs {
            width: 100%;
            height: 400px; /* 원하는 이미지 높이 */
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .r_image {
            width: 300px;
        }

        /* img 태그에 적용되는 스타일: 이 부분이 핵심 */
        .courseImages img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 이미지가 작아도 부모를 꽉 채우도록 확대 */
        }

        .courseText {
            padding: 10px 0;
            margin: 0;
        }

        /* 마우스를 올렸을 때 나타나는 텍스트 컨테이너 */
        .image-overlay {
            position: absolute; /* 부모 요소(courseImages)에 상대적 위치 지정 */
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6); /* 반투명한 검정 배경 */
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            opacity: 0; /* 평소에는 투명하게 숨김 */
            transition: opacity 0.3s ease-in-out; /* 부드러운 전환 효과 */
            text-align: center;
            padding: 10px;
            box-sizing: border-box;
            font-size: 20px;
        }

        /* 이미지 컨테이너에 마우스를 올렸을 때 오버레이가 나타남 */
        .courseItem .courseImages:hover .image-overlay,
        .courseItem .courseImgs:hover .image-overlay {
            opacity: 1; /* 마우스를 올리면 보이게 함 */
        }

        /* 기존의 courseText는 그대로 유지 */
        .courseText {
            text-align: center;
            padding: 10px 0;
            margin: 0;
        }

        /* 이미지 컨테이너: 마우스 오버레이의 기준이 됨 */
        .courseItem .courseImages, .courseItem .courseImgs {
            width: 100%;
            height: 230px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            box-sizing: border-box;
            position: relative; /* 👈 이 속성을 추가해야 합니다. */
        }

        /* 슬라이드 컨테이너 */
        .slide-container {
            position: relative; /* 화살표 버튼의 위치 기준이 됨 */
            width: 800px; /* 원하는 너비로 설정 (코스상세 이미지와 동일하게) */
            margin: 0 auto;
            overflow: hidden; /* 슬라이드 영역을 벗어나는 이미지 숨김 */
        }

        /* 이미지 목록 (슬라이드 트랙) */
        .slide-wrapper {
            display: flex; /* 이미지를 가로로 나열 */
            transition: transform 0.5s ease-in-out; /* 부드러운 전환 효과 */
        }

        /* 각 이미지 슬라이드 아이템 */
        .slide-item {
            flex-shrink: 0; /* 슬라이드 아이템이 줄어들지 않도록 함 */
            width: 100%;
        }

        /* 슬라이드 이미지 */
        .slide-item img {
            width: 100%;
            height: 450px; /* 원하는 높이로 고정 */
            object-fit: cover; /* 이미지가 컨테이너를 꽉 채우도록 */
        }

        /* 이미지 없을 때 텍스트 스타일 */
        .slide-item .emptyText {
            width: 100%;
            height: 450px;
            background-color: #f0f0f0;
            color: #888;
            font-size: 24px;
            font-weight: bold;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* 이전/다음 버튼 */
        .prev-btn, .next-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: transparent; /* 배경색을 투명하게 만듭니다. */
            color: white;
            border: none;
            padding: 15px;
            cursor: pointer;
            font-size: 20px;
            z-index: 10;
        }

        .prev-btn {
            left: 0;
        }

        .next-btn {
            right: 0;
        }

        /* 슬라이드 이미지 아래 정보 표시 영역 */
        .slide-info {
            width: 800px;
            margin: 20px auto;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            display: flex; /* 자식 요소들을 가로로 정렬 */
            justify-content: space-around; /* 요소들 사이에 균등한 간격 배분 */
            align-items: center; /* 세로 중앙 정렬 */
        }

        .slide-info p {
            margin: 0;
            text-align: center;
            flex-grow: 1; /* 가로 공간을 균등하게 차지하도록 함 */
        }


    </style>
</head>
<body>
<c:import url="/common/header.jsp"/>

<a href="javascript:history.back()" class="back-button">
    <i class="fas fa-arrow-left"></i>
</a>
<c:set var="Dvo" value="${requestScope.getAr}"/>
<c:set var="Cvo" value="${requestScope.couserAr}"/>
<c:set var="CvoInfo" value="${requestScope.courseInfo}"/>
<c:set var="rSet" value="${requestScope.restaurantSet}"/>
<c:set var="aSet" value="${requestScope.accommodationSet}"/>
<div id="main">
    <h3 class="tag" style="padding: 30px 30px;">${Dvo.title}</h3>

    <div id="detailsInfo">
        <ul>
            <li>
                <c:forEach var="Info" items="${CvoInfo}" varStatus="count">
                <c:if test="${not empty Info}">
                <strong><span>■ 테마</span></strong>
                <c:choose>
                    <c:when test="${not empty Info.theme}">
                        <span>${Info.theme}</span>
                    </c:when>
                    <c:otherwise>
                        <span>[정보없음]</span>
                    </c:otherwise>
                </c:choose>
            </li>
            <li>
                <strong><span>■ 코스 소요시간</span></strong>
                <c:choose>
                    <c:when test="${not empty Info.schedule}">
                            <span>
                                    ${Info.schedule}
                            </span>
                    </c:when>
                    <c:otherwise>
                        <span>[정보없음]</span>
                    </c:otherwise>
                </c:choose>
            </li>
            <li>
                <strong><span>■ 총거리</span></strong>
                <c:choose>
                    <c:when test="${not empty Info.distance}">
                        <span>${Info.distance}</span>
                    </c:when>
                    <c:otherwise>
                        <span>[정보없음]</span>
                    </c:otherwise>
                </c:choose>
            </li>
            </c:if>
            </c:forEach>
        </ul>
    </div>

    <p class="lineDetails_2">

    <h3 class="infoText">여행코스</h3>
    <p class="lineDetails">
    <p style="align-self: flex-start; padding-bottom: 10px">[전체 이동 경로]</p>
    <div id="subnameCourse" style="display: flex; flex-wrap: wrap; align-items: center; gap: 5px;">
        <c:forEach var="sName" items="${Cvo}" varStatus="status">
            <c:if test="${not empty sName.subname}">
        <span>
            ${sName.subname}
            <c:if test="${!status.last}">
                >
            </c:if>
        </span>
            </c:if>
        </c:forEach>
    </div>
    <%--    지도영역--%>
    <div class="map-container">
        <div id="mapDetails" style="padding: 30px 30px;margin-left: -80px">
            <div id="map" style="width: 850px; height: 300px; margin-left: 80px; "></div>
            <div id="resultMap"></div>
        </div>
    </div>

    <h3 class="infoText">코스상세</h3>
    <p class="lineDetails">

        <c:forEach var="course" items="${Cvo}" varStatus="status">
    <div class="courseItems">
        <div class="courseImgs">
            <c:if test="${not empty course.firstimage}">
                <img src="${course.firstimage}" class="course-image">
            </c:if>
            <c:if test="${empty course.firstimage}">
                <div class="image-container">
                        <%--                    <c:if test="${empty Dvo.firstimage}">--%>
                    <div class="emptyText">
                        [이미지없음]
                    </div>
                        <%--                    </c:if>--%>
                </div>
            </c:if>
        </div>
            <%-- target:클릭 시 브라우저에서 새로운 탭 또는 창/noopener:새 창이 window.opener 속성을 통해 원래 창에 접근하는 것을 방지
             noreferrer:원래 페이지의 주소 정보를 보호--%>
        <p class="courseText_1"><a href="${course.homepageUrl}" target="_blank"
                                   rel="noopener noreferrer"> ${course.title}</a></p>
        <p class="courseText_1">${course.overview}</p>
    </div>
    </c:forEach>

    <h3 class="infoText">식당정보</h3>
    <p class="lineDetails">
    <div class="courseGrid">
        <c:forEach var="r" items="${rSet}" varStatus="count">
            <div class="courseItem">
                <div class="courseImages">
                    <c:if test="${not empty r.firstimage}">
                        <img src="${r.firstimage}" class="r_image">
                    </c:if>
                    <c:if test="${empty r.firstimage}">
                        <div class="emptyText">[이미지없음]</div>
                    </c:if>
                    <div class="image-overlay">
                        <c:if test="${not empty r.tel}">
                            ${r.tel}
                            <br/>
                        </c:if>
                        <c:if test="${empty r.tel}">
                        </c:if>
                        <c:if test="${not empty r.addr1}">
                            ${r.addr1}
                        </c:if>
                        <c:if test="${empty r.addr1}">

                        </c:if>
                    </div>
                </div>
                <p class="courseText">${r.title}</p>
            </div>
        </c:forEach>
    </div>


    <h3 class="infoText">숙박정보</h3>
    <p class="lineDetails">
    <div class="slide-container accommodation-slide-container">
        <div class="slide-wrapper">
            <c:forEach var="a" items="${aSet}" varStatus="count">
                <div class="slide-item" data-tel="${a.tel}" data-addr="${a.addr1}">
                    <c:if test="${not empty a.firstimage}">
                        <img src="${a.firstimage}" alt="${a.title}">
                    </c:if>
                    <c:if test="${empty a.firstimage}">
                        <div class="emptyText">[이미지없음]</div>
                    </c:if>
                </div>
            </c:forEach>
        </div>
        <button class="prev-btn">❮</button>
        <button class="next-btn">❯</button>
    </div>
    <div class="slide-info">
        <p><strong>전화번호:</strong> <span class="slide-tel"></span></p>
        <p><strong>주소:</strong> <span class="slide-addr"></span></p>
    </div>
</div>


<c:import url="/common/footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">

    var coursePoints = [];
    <c:forEach var="vo" items="${requestScope.couserAr}">
    var point = {
        mapx: "${vo.mapx}",
        mapy: "${vo.mapy}"
    };
    coursePoints.push(point);
    </c:forEach>

    $(function () {
        $.ajax({
            url: "Controller?type=findWay",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(coursePoints)
        }).done(function (res) {
            $("#resultMap").html(res);
        });
    });

    var mapContainer = document.getElementById('map');
    var mapOption = {
        center: new kakao.maps.LatLng(coursePoints[0].mapy, coursePoints[0].mapx),
        level: 5
    };
    var map = new kakao.maps.Map(mapContainer, mapOption);

    mapContainer.style.width = '850px';
    mapContainer.style.height = '300px';

    <%--var marker = new kakao.maps.Marker({--%>
    <%--position: new kakao.maps.LatLng(${Cvo.mapy}, ${Cvo.mapx}),--%>
    <%--map: map,--%>
    // });

    $(function () {

        var accommodationContainer = $('.accommodation-slide-container');
        initSlide(accommodationContainer);

        function initSlide(container) {
            var slideWrapper = container.find('.slide-wrapper');
            var slides = slideWrapper.find('.slide-item');
            var currentIndex = 0;
            var slideCount = slides.length;
            var slideWidth = 800;

            var infoContainer = container.next('.slide-info');
            var telEl = infoContainer.find('.slide-tel');
            var addrEl = infoContainer.find('.slide-addr');

            updateInfo(slides.eq(currentIndex), telEl, addrEl);

            container.find('.prev-btn').click(function () {
                currentIndex = (currentIndex > 0) ? currentIndex - 1 : slideCount - 1;
                updateSlideAndInfo();
            });

            container.find('.next-btn').click(function () {
                currentIndex = (currentIndex < slideCount - 1) ? currentIndex + 1 : 0;
                updateSlideAndInfo();
            });

            function updateSlideAndInfo() {
                slideWrapper.css('transform', 'translateX(' + (-slideWidth * currentIndex) + 'px)');
                updateInfo(slides.eq(currentIndex), telEl, addrEl);
            }

            function updateInfo(currentSlide, telEl, addrEl) {
                var tel = currentSlide.data('tel');
                var addr = currentSlide.data('addr');

                telEl.text(tel || '[정보없음]');
                addrEl.text(addr || '[정보없음]');
            }
        }
    });

</script>
</body>
</html>
