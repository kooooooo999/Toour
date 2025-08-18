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

        .courseItems, .courseRestaurant {
            display: flex;
            flex-direction: column; /* 자식 요소들을 수직으로 정렬 */
            align-items: center; /* 수평 중앙 정렬 */
            margin-bottom: 30px; /* 아이템 간 간격 추가 */
        }

        .courseImgs {
            width: 800px;
            height: 450px;
            overflow: hidden; /* 이미지가 컨테이너를 벗어나는 부분을 숨김 */
            display: flex; /* 이미지를 중앙 정렬하기 위해 추가 */
            justify-content: center;
            align-items: center;
        }

        .course-image {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 이미지가 컨테이너를 채우도록 확대/축소 */
        }

        .courseText {
            text-align: center;
            padding: 10px 20px;
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

        /* 또는, .courseRestaurant과 #courseAccommodation의 마진을 조절합니다. */
        .courseRestaurant, #courseAccommodation {
            margin-top: 10px; /* 위쪽 여백을 줄임 */
            margin-bottom: 20px; /* 아래쪽 여백을 줄임 */
        }

        /* 식당 정보와 숙박 정보를 동일하게 중앙 정렬하기 위한 스타일 */
        .courseRestaurant, .courseAccommodationItem {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 30px;
            /* 추가적인 여백 조절이 필요하면 margin 값을 조정하세요. */
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
    <div id="heartImagedetails">
        <p class="heartIcon"><i class="fa-solid fa-heart"></i></p>
    </div>

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
    <%--지도영역--%>
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
            <c:if test="${not empty course.subdetailimg}">
                <img src="${course.subdetailimg}" class="course-image">
            </c:if>
            <c:if test="${empty course.subdetailimg}">
                <div class="image-container">
                    <c:if test="${empty Dvo.firstimage}">
                        <div class="emptyText">
                            [이미지없음]
                        </div>
                    </c:if>
                    <c:if test="${not empty Dvo.firstimage}">
                        <img src="${Dvo.firstimage}" class="imageDetails">
                    </c:if>
                </div>
            </c:if>
        </div>
        <p class="courseText">${course.subdetailalt}</p>
        <p class="courseText">${course.subdetailoverview}</p>
    </div>
    </c:forEach>

    <h3 class="infoText">식당정보</h3>
    <p class="lineDetails">
        <c:forEach var="r" items="${rSet}" varStatus="count">
    <div class="courseRestaurant">
        <div class="courseImgs">
            <c:if test="${not empty r.firstimage}">
                <img src="${r.firstimage}" class="image">
            </c:if>
            <div class="image-container">
                <c:if test="${empty r.firstimage}">
                    <div class="emptyText">
                        [이미지없음]
                    </div>
                </c:if>
            </div>
        </div>
        <p class="courseText">${r.title}</p>
    </div>
    </c:forEach>

    <h3 class="infoText">숙박정보</h3>
    <p class="lineDetails">

    <div id="courseAccommodation">
        <c:forEach var="a" items="${aSet}" varStatus="count">
            <div id="AccommodationItems">
                <div class="courseImgs">
                    <c:if test="${not empty a.firstimage}">
                        <img src="${a.firstimage}" class="image">
                    </c:if>
                    <div class="image-container">
                        <c:if test="${empty a.firstimage}">
                            <div class="emptyText">
                                [이미지없음]
                            </div>
                        </c:if>
                    </div>
                </div>
                <p class="courseText">${a.title}</p>
            </div>
        </c:forEach>

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
                console.log("됐니");
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


    </script>
</body>
</html>
