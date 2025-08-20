<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<div class="main-content" id="post">
    <h1>문의사항 관리</h1>
    <div>
        <div>

            <c:set var="p" value="${requestScope.page}" scope="page"/>
            <c:forEach var="Ivo" items="${requestScope.IvoArr}" varStatus="count">
                <c:if test="${count.index < 10}">
                    <tr onclick="inquiryDetails()">
                        <td>${Ivo.inquiry_idx}</td>
                        <td>${Ivo.category}</td>
                        <td>${Ivo.title}</td>
                        <td>${Ivo.member_nickname}</td>
                        <td>${Ivo.is_read}</td>
                        <td>${Ivo.status}</td>
                        <td>${Ivo.created_at}</td>
                    </tr>
                </c:if>
            </c:forEach>

        </div>
    </div>
</div>