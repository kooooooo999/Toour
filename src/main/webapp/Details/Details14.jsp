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
            <strong>■ 유모차 대여 정보</strong>
            <div>${Dvo2.chkbabycarriage}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.chkpetculture}">
        <li>
            <strong>■ 애완동물 동반 가능 여부</strong>
            <div>${Dvo2.chkpetculture}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.infocenter}">
        <li>
            <strong>■ 문의 및 안내</strong>
            <p>
                <c:out value="${fn:replace(Dvo2.infocenter, ' 0', '<br/>')}" escapeXml="false"/>
            </p>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.parking}">
        <li>
            <strong>■ 주차 시설</strong>
            <div>${Dvo2.parking}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.parkingfee}">
        <li>
            <strong>■ 주차 요금</strong>
            <div>${Dvo2.parkingfee}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.restdate}">
        <li>
            <strong>■ 쉬는 날</strong>
            <div>${Dvo2.restdate}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.scale}">
        <li>
            <strong>■ 규모</strong>
            <div>${Dvo2.scale}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.usetimeculture}">
        <li>
            <strong>■ 이용 시간</strong>
            <div>${Dvo2.usetimeculture}</div>
        </li>
    </c:if>
</c:forEach>
</html>
