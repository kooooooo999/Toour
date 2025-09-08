<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<div id="detailsInfo">
    <ul>
        <c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">
            <li>
                <strong>■ 예약 링크</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.homepageUrl}">
                        <div><a href="${Dvo2.homepageUrl}" target="_blank"
                                rel="noopener noreferrer">${Dvo2.homepageUrl}</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 체크인 시간</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.checkintime}">
                        <div>${Dvo2.checkintime}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 체크아웃 시간</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.checkouttime}">
                        <div>${Dvo2.checkouttime}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 조리 가능 여부</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.chkcooking}">
                        <div>${Dvo2.chkcooking}</div>
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
                <strong>■ 객실 수</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.roomcount}">
                        <div>${Dvo2.roomcount}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 객실 유형</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.roomtype}">
                        <div>${Dvo2.roomtype}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 부대시설</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.subfacility}">
                        <div>${Dvo2.subfacility}</div>
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
