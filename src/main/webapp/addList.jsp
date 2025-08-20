<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:forEach items="${sessionScope.member.courseList}" var="list" varStatus="vs">
    <div id="course">
        <div style="display: inline-block;">
            <button type="button" class="minusButton" onclick="removeList('${list.title}',${vs.index})"></button>
            <p class="ellip" style="display: inline-block;">${list.title}(${vs.index+1})</p>
            <p class="ellip" style="display: block; font-weight: bold; font-size: 10px; color: #6c757d">${list.addr1}</p>
        </div>
    </div>
        <c:if test="${fn:length(sessionScope.member.courseList) != (vs.index+1)}">
            <hr style="margin-top: 13px;" color="#eee" size="1px" width="260px;"/>
        </c:if>
</c:forEach>

<input type="hidden"  id="courseList" value="${sessionScope.member.courseList}"/>

<script>

    <c:if test="${fn:length(sessionScope.member.courseList) > 0}">
        $("#saveButton").show();
    </c:if>
    <c:if test="${fn:length(sessionScope.member.courseList) == 0}">
        $("#saveButton").hide();
    </c:if>
    var coursePoints = [];
    var points = [];

    <c:forEach var="vo" items="${sessionScope.courseList}">
    var point = {
        mapx: "${vo.mapx}",
        mapy: "${vo.mapy}"
    };
    coursePoints.push(point);
    </c:forEach>

    <c:forEach var="list" items="${sessionScope.courseList}">
    points.push(new kakao.maps.LatLng(${list.mapy}, ${list.mapx}));
    </c:forEach>


</script>