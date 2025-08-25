<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


    <div class="container" id="inquiry-container">

        <div id="inquiry-header-container">
        </div>
        <!-- 문의 목록 테이블 -->
        <table class="inquiry-table">
            <caption>문의 목록 테이블</caption>

            <thead>
            <tr>
                <th width="10%">번호</th>
                <th width="15%">유형</th>
                <th width="30%">제목</th>
                <th width="15%">상태</th>
                <th width="15%">작성일</th>
                <th width="15%">관리</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="p2" value="${requestScope.InquiryPage}" />
            <c:set var="inquiryList" value="${requestScope.myInquiry_ar}"/>
            <c:choose>
                <c:when test="${not empty inquiryList and fn:length(inquiryList) > 0}">
                    <c:forEach items="${inquiryList}" var="ivo" varStatus="vs">
                        <c:if test="${not empty ivo}">
                            <c:set var="num2" value="${p2.totalCount -((p2.nowPage-1)*p2.numPerPage+vs.index)}"/>
                            <tr>
                                <td>${num2}</td>
                                <td>${ivo.category}</td>
                                <td style="text-align: left">
                                    <a href="Controller?type=inquiryView&inquiry_idx=${ivo.inquiry_idx}&cPage=${p2.nowPage}">
                                            ${ivo.title}
                                    </a>
                                </td>

                                <td><span class="status-badge status-${ivo.statusColor}">${ivo.status}</span></td>
                                <td>${ivo.created_at.substring( 0, 10)}</td>
                                <td>
                                    <a href="Controller?type=inquiryView&inquiry_idx=${ivo.inquiry_idx}" class="btn btn-primary">보기</a>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </c:when>

                <c:otherwise>
                    <tr>
                        <td colspan="6" class="no-data" style="text-align: center; padding: 50px;">
                            <div class="no-result">
                                <c:choose>
                                    <c:when test="${not empty requestScope.myInquiry_ar}">

                                    </c:when>
                                    <c:otherwise> 등록된 문의가 없습니다</c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

        <!-- 페이징 -->
    </div>




