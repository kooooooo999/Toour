<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

    </style>
</head>
<body>
<c:import url="/common/header.jsp" />


<div class="map-container">
    <div id="mapDetails">
        <div id="map" style="width: 850px; height: 300px; margin-left: 80px"></div>
    </div>
</div>



<c:import url="/common/footer.jsp" />

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">

    <c:forEach var="Dvo" items="${requestScope.dataAr}" varStatus="count">
    var mapContainer = document.getElementById('map');
    var mapOption = {
        center: new kakao.maps.LatLng(${Dvo.mapy}, ${Dvo.mapx}),
        level: 5
    };
    var map = new kakao.maps.Map(mapContainer, mapOption);

        mapContainer.style.width = '850px';
        mapContainer.style.height = '300px';

        var marker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(${Dvo.mapy}, ${Dvo.mapx}),
        map: map,
    });
    </c:forEach>

</script>
</body>
</html>
