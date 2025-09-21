<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">
    <c:if test="${not empty Dvo2.homepageUrl}">
        <li>
            <strong>■ 예약 링크</strong>
            <div><a href="${Dvo2.homepageUrl}" target="_blank"
                    rel="noopener noreferrer">${Dvo2.homepageUrl}</a>
            </div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.checkintime}">
        <li>
            <strong>■ 체크인 시간</strong>
            <div>${Dvo2.checkintime}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.checkouttime}">
        <li>
            <strong>■ 체크아웃 시간</strong>
            <div>${Dvo2.checkouttime}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.chkcooking}">
        <li>
            <strong>■ 조리 가능 여부</strong>
            <div>${Dvo2.chkcooking}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.infocenter}">
        <li>
            <strong>■ 문의 안내</strong>
            <div>${Dvo2.infocenter}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.parking}">
        <li>
            <strong>■ 주차 가능</strong>
            <div>${Dvo2.parking}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.roomcount}">
        <li>
            <strong>■ 객실 수</strong>
            <div>${Dvo2.roomcount}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.roomtype}">
        <li>
            <strong>■ 객실 유형</strong>
            <div>${Dvo2.roomtype}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.subfacility}">
        <li>
            <strong>■ 부대시설</strong>
            <div>${Dvo2.subfacility}</div>
        </li>
    </c:if>
</c:forEach>
</html>
