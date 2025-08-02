<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 1.
  Time: 오후 12:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<article>
    <c:if test="${not empty ar}">
        <c:set var="p" value="${requestScope.page}" />
        <c:forEach items="${ar}" var="vo" varStatus="vs">
            <c:set var="num" value="${p.totalCount -((p.nowPage-1)*p.numPerPage+vs.index)}"/>
            <tr>
                <td>${num}</td>
                <td style="text-align: left">
                    <a href="Controller?type=headSearch&post_idx=${vo.post_idx}&cPage=${nowPage}">
                            ${vo.post_title}
                        <c:if test="${vo.c_list != null and fn:length(vo.c_list) > 0}">
                            (<c:out value="${fn:length(vo.c_list)}"/>)
                        </c:if>
                    </a>
                </td>
                <td>${fn:length(vo.c_list)}</td>
                <td>${vo.member_nickname}</td>
                <td>${vo.post_star}</td>
                <td>${vo.post_views}</td>
                <td>${vo.post_created_at.substring(0,10)}</td>
            </tr>
        </c:forEach>
    </c:if>
</article>
<div class="paging-area">
    <ol class="paging">
        <c:set var="p" value="${requestScope.page}" />
        <c:if test="${p.startPage < p.pagePerBlock}">
            <li class="disable">&lt;</li>
        </c:if>
        <c:if test="${p.startPage >= p.pagePerBlock}">
            <li><a href="Controller?type=headSearch&cPage=${p.startPage-p.pagePerBlock}">&lt;</a></li>
        </c:if>
        <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
            <c:if test="${p.nowPage == vs.index}">
                <li class="now">${vs.index}</li>
            </c:if>
            <c:if test="${p.nowPage != vs.index}">
                <li><a href="Controller?type=headSearch&cPage=${vs.index}">${vs.index}</a></li>
            </c:if>
        </c:forEach>
        <c:if test="${p.endPage < p.totalPage}">
            <li><a href="Controller?type=headSearch&cPage=${p.endPage+1}">&gt;</a></li>
        </c:if>
        <c:if test="${p.endPage >= p.totalPage}">
            <li class="disable">&gt;</li>
        </c:if>
    </ol>
    <input type="button" value="검색" onclick="javascript:location.href='Controller?type=headSearch'">
</div>

</body>
</html>
