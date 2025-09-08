<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<div id="detailsInfo">
    <ul>
        <c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">

            <li>
                <strong>■ 수용 인원</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.accomcount}">
                        <div>${Dvo2.accomcount}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 유모차 대여 정보</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.chkbabycarriage}">
                        <div>${Dvo2.chkbabycarriage}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 애완동물 동반 가능 여부</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.chkpetculture}">
                        <div>${Dvo2.chkpetculture}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 문의 및 안내</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.infocenter}">
                        <p>
                            <c:out value="${fn:replace(Dvo2.infocenter, ' 0', '<br/>')}" escapeXml="false"/>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 주차 시설</strong>
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
                <strong>■ 주차 요금</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.parkingfee}">
                        <div>${Dvo2.parkingfee}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 쉬는 날</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.restdate}">
                        <div>${Dvo2.restdate}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 규모</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.scale}">
                        <div>${Dvo2.scale}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 이용 시간</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.usetimeculture}">
                        <div>${Dvo2.usetimeculture}</div>
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
