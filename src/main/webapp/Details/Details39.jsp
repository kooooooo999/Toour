<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">
    <c:if test="${not empty Dvo2.firstmenu}">
        <li>
            <strong>■ 대표 메뉴</strong>
            <div>${Dvo2.firstmenu}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.infocenter}">
        <li>
            <strong>■ 문의 안내</strong>
            <div>${Dvo2.infocenter}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.opentimefood}">
        <li>
            <strong>■ 영업 시간</strong>
            <div>${Dvo2.opentimefood}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.parking}">
        <li>
            <strong>■ 주차 가능</strong>
            <div>${Dvo2.parking}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.seat}">
        <li>
            <strong>■ 좌석 수</strong>
            <div>${Dvo2.seat}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.packing}">
        <li>
            <strong>■ 포장 가능 여부</strong>
            <div>${Dvo2.packing}</div>
        </li>
    </c:if>
</c:forEach>
</html>
