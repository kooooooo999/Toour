<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>

<html>
<style>
    /* 지도를 감싸는 부모 컨테이너에 적용 */
    .map-container {
        display: flex;
        justify-content: center; /* 자식 요소를 가로 중앙으로 정렬 */
        width: 100%;
        padding-bottom: 40px; /* 아래 여백 */
    }

    /* 상세 정보를 감싸는 부모 컨테이너에 적용 */
    #detailsInfo {
        display: flex;
        justify-content: center; /* ul을 가로 중앙으로 정렬 */
        width: 100%;
        padding-bottom: 50px;
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
  }
     /* 뒤로가기 버튼 스타일 */
   .back-button {
     position: fixed; /* 👈 스크롤에 상관없이 화면에 고정 */
     bottom: 20px;    /* 👈 화면 아래쪽에서 20px 떨어진 위치 */
     left: 20px;      /* 👈 화면 왼쪽에서 20px 떨어진 위치 */
     z-index: 1000;   /* 다른 요소보다 위에 표시 */

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

    /* 이미지를 감싸는 부모 컨테이너 */
    .image-container {
        width: 500px;
        height: 250px;
        position: relative; /* 자식 요소의 위치 기준이 됨 */
    }

    #heartImagedetails > p > i {
        color: #f00;
    }


    /* 이미지를 감싸는 부모 컨테이너 */
    .image-container {
        width: 500px;
        height: 250px;
        position: relative; /* 자식 요소의 위치 기준이 됨 */
    }

    /* 이미지 스타일 (이미지가 있을 때) */
    .image-container .image {
        width: 100%;
        height: 100%;
        object-fit: cover; /* 이미지가 컨테이너를 꽉 채우도록 설정 */
    }

    /* 이미지가 없을 때의 텍스트 스타일 */
    .image-container .emptyText {
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

</style>

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

    </style>

</head>
<body>

<c:import url="/common/header.jsp"/>

<a href="javascript:history.back()" class="back-button">
    <i class="fas fa-arrow-left"></i>
</a>

<div id="main">
    <c:set var="Dvo" value="${requestScope.detailsAr}"/>
    <h1 class="tag">${Dvo.title}</h1>
    <p class="lineDetails">
    <div id="heartImagedetails">
        <p class="heartIcon" id="heartIcon"><i id="heart"
                                               <c:if test="${!requestScope.zzim_state}">class="fa-regular fa-heart"</c:if>
                                               <c:if test="${requestScope.zzim_state}">class="fa-solid fa-heart"</c:if> ></i>
        </p>
    </div>
    <div class="image-container">
        <c:if test="${empty Dvo.firstimage}">
            <div class="emptyText">
                [이미지없음]
            </div>
        </c:if>
        <c:if test="${not empty Dvo.firstimage}">
            <img src="${Dvo.firstimage}" class="image">
        </c:if>
    </div>


    <h3 class="infoText">상세정보</h3>
    <p class="lineDetails">


    <p class="overviewDetails">${Dvo.overview}</p>

</div>

<%--지도영역--%>
<div class="map-container">
    <div id="mapDetails">
        <div id="map" style="width: 850px; height: 300px; "></div>
    </div>
</div>

<%--주차 가능여부 등 API 새로 가져오기--%>

<%--String accomcount =  item.getChildText("accomcount"); //수용인원--%>
<%--String chkpet =  item.getChildText("chkpet"); //애완동물동반가능정보--%>
<%--String infocenter =  item.getChildText("infocenter"); //문의안내--%>
<%--String parking =   item.getChildText("parking"); //주차시설--%>
<%--String restdate =  item.getChildText("restdate"); //쉬는날--%>
<%--String usetime =   item.getChildText("usetime"); //이용시간--%>
<div id="detailsInfo">
    <ul>
        <c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">

            <li>
                <strong><span>■ 문의안내</span></strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.infocenter}">
                        <p>
                            <c:out value="${fn:replace(Dvo2.infocenter, ' 0', '<br/>')}" escapeXml="false"/>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <span>[정보없음]</span>
                    </c:otherwise>
                </c:choose>
            </li>
            <li>
                <strong><span>■ 상세주소</span></strong>
                <c:choose>
                    <c:when test="${not empty Dvo.addr1 or not empty Dvo.addr2}">
                        <span>${Dvo.addr1} ${Dvo.addr2}</span>
                    </c:when>
                    <c:otherwise>
                        <span>[정보없음]</span>
                    </c:otherwise>
                </c:choose>
            </li>
            <li>
                <strong><span>■ 주차시설</span></strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.parking}">
                        <span>${Dvo2.parking}</span>
                    </c:when>
                    <c:otherwise>
                        <span>[정보없음]</span>
                    </c:otherwise>
                </c:choose>
            </li>
            <li>
                <strong><span>■ 이용시간</span></strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.usetime}">
                        <span>${Dvo2.usetime}</span>
                    </c:when>
                    <c:otherwise>
                        <span>[정보없음]</span>
                    </c:otherwise>
                </c:choose>
            </li>
            <li>
                <strong><span>■ 쉬는날</span></strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.restdate}">
                        <span>${Dvo2.restdate}</span>
                    </c:when>
                    <c:otherwise>
                        <span>[정보없음]</span>
                    </c:otherwise>
                </c:choose>
            </li>
            <li>
                <strong><span>■ 홈페이지</span></strong>
                <c:choose>
                    <c:when test="${not empty Dvo.homepageUrl}">
                        <span><a href="${Dvo.homepageUrl}" target="_blank"
                                 rel="noopener noreferrer">${Dvo.homepageText}</a></span>
                    </c:when>
                    <c:otherwise>
                        <span>[정보없음]</span>
                    </c:otherwise>
                </c:choose>
            </li>
        </c:forEach>
    </ul>
</div>

<c:import url="/common/footer.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">

    var mapContainer = document.getElementById('map');
    var mapOption = {
        center: new kakao.maps.LatLng(${Dvo.mapy}, ${Dvo.mapx}),
        level: 5
    };
    var map = new kakao.maps.Map(mapContainer, mapOption);

    var marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(${Dvo.mapy}, ${Dvo.mapx}),
        map: map,
    });


    $("#heartIcon").on("click", function () {
        // Action에서 추가인지 삭제인지 구분하기 위한 값
        let state = null;

        if ($("#heart").hasClass("fa-regular fa-heart")) {
            //빈 하트 눌렀을 때 if
            $("#heart").removeClass("fa-regular fa-heart")
            $("#heart").addClass("fa-solid fa-heart")
            //찜 목록에 add해라
            state = "add";
        } else {
            // 꽉 찬 하트를 눌렀을 때 else
            $("#heart").removeClass("fa-solid fa-heart")
            $("#heart").addClass("fa-regular fa-heart")

            //찜 목록에 delete해라
            state = "delete";
        }

        //Action만 가서 해당 회원의 찜목록에 저장
        $.ajax({
            url: "Controller?type=addDeleteZzim",
            type: "POST",
            data: {contentId:${Dvo.contentId}, state: state, contentTypeId:${Dvo.contentTypeId}}
        })

    })


</script>

</body>
</html>