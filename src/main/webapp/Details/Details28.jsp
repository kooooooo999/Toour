<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">
    <c:if test="${not empty Dvo2.accomcount}">
        <li>
            <strong>■ 수용 인원</strong>
            <div>${Dvo2.accomcount}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.chkbabycarriage}">
        <li>
            <strong>■ 유모차 대여</strong>
            <div>${Dvo2.chkbabycarriage}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.chkpet}">
        <li>
            <strong>■ 애완동물 동반</strong>
            <div>${Dvo2.chkpet}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.expagerange}">
        <li>
            <strong>■ 이용 가능 연령</strong>
            <div>${Dvo2.expagerange}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.infocenter}">
        <li>
            <strong>■ 문의 및 안내</strong>
            <div>${Dvo2.infocenter}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.openperiod}">
        <li>
            <strong>■ 운영 기간</strong>
            <div>${Dvo2.openperiod}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.parkingfeeleports}">
        <li>
            <strong>■ 주차 요금</strong>
            <div>${Dvo2.parkingfeeleports}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.parkingleports}">
        <li>
            <strong>■ 주차 시설</strong>
            <div>${Dvo2.parkingleports}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.reservation}">
        <li>
            <strong>■ 예약 여부</strong>
            <div>${Dvo2.reservation}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.restdate}">
        <li>
            <strong>■ 쉬는 날</strong>
            <div>${Dvo2.restdate}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.usefeeleports}">
        <li>
            <strong>■ 이용 요금</strong>
            <div>${Dvo2.usefeeleports}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.usetime}">
        <li>
            <strong>■ 이용 시간</strong>
            <div>${Dvo2.usetime}</div>
        </li>
    </c:if>
</c:forEach>
</html>
