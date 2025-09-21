<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<c:forEach items="${sessionScope.member.courseList}" var="list" varStatus="vs">
    <div id="course">
        <div style="display: inline-block;" id="myCourseList0">
            <button type="button" class="minusButton" onclick="removeList('${list.title}',${vs.index})"></button>
            <p class="ellip" style="display: inline-block;">${list.title}(${vs.index+1})</p>
            <p class="ellip" style="display: block; font-weight: bold; font-size: 10px; color: #6c757d">${list.addr1}</p>
        </div>
    </div>
        <c:if test="${fn:length(sessionScope.member.courseList) != (vs.index+1)}">
            <hr style="margin-top: 13px;" color="#eee" size="1px" width="260px;"/>
        </c:if>
</c:forEach>

<c:if test="${requestScope.courseList ne null}">
    <c:forEach items="${requestScope.courseList}" var="list" varStatus="vs">
        <div id="course">
            <div style="display: inline-block;" id="myCourseList0">
                <button type="button" class="minusButton" onclick="removeList('${list.title}',${vs.index})"></button>
                <p class="ellip" style="display: inline-block;">${list.title}(${vs.index+1})</p>
                <p class="ellip" style="display: block; font-weight: bold; font-size: 10px; color: #6c757d">${list.addr1}</p>
            </div>
        </div>
        <c:if test="${fn:length(requestScope.courseList) != (vs.index+1)}">
            <hr style="margin-top: 13px;" color="#eee" size="1px" width="260px;"/>
        </c:if>
    </c:forEach>
</c:if>

<input type="hidden" id="courseDate_idx" value="${requestScope.courseDate_idx}"/>

<script>
    $(function () {

        <c:if test="${requestScope.courseList ne null}">
        console.log("kiki2")

        $("#saveButton").show();

        </c:if>


        <%-- 코스 리스트 창에 아무것도 없을 때는 코스 저장 버튼 숨기기 --%>
        <c:if test="${requestScope.courseList eq null}">
            <c:if test="${fn:length(sessionScope.member.courseList) > 0}">
                console.log("kiki")
                <c:if test="${requestScope.myCourse ne 'myCourse'}">
                $("#saveButton").show();
                </c:if>
            </c:if>
        </c:if>


        <c:if test="${requestScope.myCourse eq 'myCourse'}">
            $("#editCourseButton").show();
        </c:if>

        <c:if test="${requestScope.courseList eq null}">
            <c:if test="${fn:length(sessionScope.member.courseList) == 0}">
                $("#saveButton").hide();
            </c:if>
        </c:if>
    });


    var coursePoints = [];
    var points = [];


    <c:forEach var="vo" items="${sessionScope.member.courseList}">
    var point = {
        mapx: "${vo.mapx}",
        mapy: "${vo.mapy}"
    };
    coursePoints.push(point);
    </c:forEach>

    <c:forEach var="list" items="${sessionScope.member.courseList}">
        points.push(new kakao.maps.LatLng(${list.mapy}, ${list.mapx}));
    </c:forEach>


    <c:if test="${requestScope.courseList ne null}">
    <c:forEach var="vo" items="${requestScope.courseList}">
    var point = {
        mapx: "${vo.mapx}",
        mapy: "${vo.mapy}"
    };
    coursePoints.push(point);
    </c:forEach>

    <c:forEach var="list" items="${requestScope.courseList}">
    points.push(new kakao.maps.LatLng(${list.mapy}, ${list.mapx}));
    </c:forEach>
    </c:if>

</script>