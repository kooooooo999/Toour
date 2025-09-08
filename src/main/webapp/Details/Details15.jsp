<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<div id="detailsInfo">
    <ul>
        <c:forEach var="Dvo2" items="${requestScope.detailsAr_2}">

            <li>
                <strong>■ 관람 소요시간</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.spendtime}">
                        <div>${Dvo2.spendtime}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 관람 가능 연령</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.agelimit}">
                        <div>${Dvo2.agelimit}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 예매처</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.bookingplace}">
                        <div>${Dvo2.bookingplace}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 행사 시작일</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.eventstartdate}">
                        <div>${Dvo2.eventstartdate}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 행사 종료일</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.eventenddate}">
                        <div>${Dvo2.eventenddate}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 행사 홈페이지</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.eventhomepage}">
                        <div><a href="${Dvo2.eventhomepage}" target="_blank"
                                rel="noopener noreferrer">${Dvo2.eventhomepage}</a></div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 행사 장소</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.eventplace}">
                        <div>${Dvo2.eventplace}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 공연 시간</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.playtime}">
                        <div>${Dvo2.playtime}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 프로그램 소개</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.program}">
                        <p>
                            <c:out value="${fn:replace(Dvo2.program, ' 0', '<br/>')}" escapeXml="false"/>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 주최 기관</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.sponsor1}">
                        <div>${Dvo2.sponsor1}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 주최 기관 연락처</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.sponsor1tel}">
                        <div>${Dvo2.sponsor1tel}</div>
                    </c:when>
                    <c:otherwise>
                        <div>[정보없음]</div>
                    </c:otherwise>
                </c:choose>
            </li>

            <li>
                <strong>■ 이용 요금</strong>
                <c:choose>
                    <c:when test="${not empty Dvo2.usetimefestival}">
                        <div>${Dvo2.usetimefestival}</div>
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
