<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">
    <c:if test="${not empty Dvo2.spendtime}">
        <li>
            <strong>■ 관람 소요시간</strong>
            <div>${Dvo2.spendtime}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.agelimit}">
        <li>
            <strong>■ 관람 가능 연령</strong>
            <div>${Dvo2.agelimit}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.bookingplace}">
        <li>
            <strong>■ 예매처</strong>
            <div>${Dvo2.bookingplace}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.eventstartdate}">
        <li>
            <strong>■ 행사 시작일</strong>
            <div>${Dvo2.eventstartdate}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.eventenddate}">
        <li>
            <strong>■ 행사 종료일</strong>
            <div>${Dvo2.eventenddate}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.eventhomepage}">
        <li>
            <strong>■ 행사 홈페이지</strong>
            <div><a href="${Dvo2.eventhomepage}" target="_blank"
                    rel="noopener noreferrer">${Dvo2.eventhomepage}</a></div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.eventplace}">
        <li>
            <strong>■ 행사 장소</strong>
            <div>${Dvo2.eventplace}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.playtime}">
        <li>
            <strong>■ 공연 시간</strong>
            <div>${Dvo2.playtime}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.program}">
        <li>
            <strong>■ 프로그램 소개</strong>
            <p>
                <c:out value="${fn:replace(Dvo2.program, ' 0', '<br/>')}" escapeXml="false"/>
            </p>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.sponsor1}">
        <li>
            <strong>■ 주최 기관</strong>
            <div>${Dvo2.sponsor1}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.sponsor1tel}">
        <li>
            <strong>■ 주최 기관 연락처</strong>
            <div>${Dvo2.sponsor1tel}</div>
        </li>
    </c:if>
    <c:if test="${not empty Dvo2.usetimefestival}">
        <li>
            <strong>■ 이용 요금</strong>
            <div>${Dvo2.usetimefestival}</div>
        </li>
    </c:if>
</c:forEach>
</html>
