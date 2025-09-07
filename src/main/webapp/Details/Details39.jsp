<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<div id="detailsInfo">
    <ul>
        <c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">

            <li>
                <strong>■ 대표 메뉴</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.firstmenu}">
                        <div>${Dvo2.firstmenu}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 문의 안내</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.infocenter}">
                        <div>${Dvo2.infocenter}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 영업 시간</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.opentimefood}">
                        <div>${Dvo2.opentimefood}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 주차 가능</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.parking}">
                        <div>${Dvo2.parking}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 좌석 수</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.seat}">
                        <div>${Dvo2.seat}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 포장 가능 여부</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.packing}">
                        <div>${Dvo2.packing}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

        </c:forEach>
    </ul>
</div>

</html>
