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
                <strong>■ 유모차 대여</strong>
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
                <strong>■ 애완동물 동반</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.chkpet}">
                        <div>${Dvo2.chkpet}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 이용 가능 연령</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.expagerange}">
                        <div>${Dvo2.expagerange}</div>
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
                        <div>${Dvo2.infocenter}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 운영 기간</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.openperiod}">
                        <div>${Dvo2.openperiod}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 주차 요금</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.parkingfeeleports}">
                        <div>${Dvo2.parkingfeeleports}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 주차 시설</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.parkingleports}">
                        <div>${Dvo2.parkingleports}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 예약 여부</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.reservation}">
                        <div>${Dvo2.reservation}</div>
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
                <strong>■ 이용 요금</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.usefeeleports}">
                        <div>${Dvo2.usefeeleports}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 이용 시간</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.usetime}">
                        <div>${Dvo2.usetime}</div>
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
