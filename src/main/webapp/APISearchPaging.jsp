<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 8.
  Time: 오후 2:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ol class="paging">
  <c:set var="p" value="${requestScope.page}"/>

  <c:if test="${p.startPage < p.pagePerBlock}">
    <li class="disable">&lt;</li>
  </c:if>

  <c:if test="${p.startPage >= p.pagePerBlock}">
    <li><a href="javascript:moveBigPage(${p.nowPage-p.pagePerBlock}),movePage(${p.nowPage-p.pagePerBlock})">&lt;</a></li>
  </c:if>

  <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
    <c:if test="${p.nowPage == vs.index}">
      <li class="current" value="${vs.index}" id="${vs.index}">${vs.index}</li>
    </c:if>

    <c:if test="${p.nowPage != vs.index}">
      <li value="${vs.index}" id="${vs.index}">
        <a href="javascript:movePage(${vs.index})">${vs.index}</a>
      </li>
    </c:if>
  </c:forEach>

  <c:if test="${p.endPage < p.totalPage}">
    <li><a href="javascript:moveBigPage(${p.nowPage+p.pagePerBlock}) , movePage(${p.nowPage+p.pagePerBlock})">&gt;</a></li>
  </c:if>

  <c:if test="${p.endPage >= p.totalPage}">
    <li class="disable">&gt;</li>
  </c:if>
</ol>

