<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<div id="detailsInfo">
    <ul>
        <c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">

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
                <strong>■ 개장일</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.opendateshopping}">
                        <div>${Dvo2.opendateshopping}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 영업 시간</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.opentime}">
                        <div>${Dvo2.opentime}</div>
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
                <strong>■ 판매 품목</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.saleitem}">
                        <div>${Dvo2.saleitem}</div>
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
