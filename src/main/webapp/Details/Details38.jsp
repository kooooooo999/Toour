<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">
    <c:if test="${not empty Dvo2.infocenter}">
        <li>
            <strong>■ 문의 안내</strong>
            <div>${Dvo2.infocenter}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.opendateshopping}">
        <li>
            <strong>■ 개장일</strong>
            <div>${Dvo2.opendateshopping}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.opentime}">
        <li>
            <strong>■ 영업 시간</strong>
            <div>${Dvo2.opentime}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.parking}">
        <li>
            <strong>■ 주차 시설</strong>
            <div>${Dvo2.parking}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.restdate}">
        <li>
            <strong>■ 쉬는 날</strong>
            <div>${Dvo2.restdate}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.saleitem}">
        <li>
            <strong>■ 판매 품목</strong>
            <div>${Dvo2.saleitem}</div>
        </li>
    </c:if>
</c:forEach>
</html>
