<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 7.
  Time: 오후 2:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:forEach var="Dvo" items="${requestScope.dataAr}" varStatus="count">
  <c:if test="${count.index < 5}">
    <div class="item">
      <img src="${Dvo.firstimage}" class="image" onclick="selectImage(this)">
      <div class="text ellipsis">
        <p class="title"><a href="#">${Dvo.title}</a></p>
        <p class="addr1"><a href="#">[${Dvo.addr1}]</a></p>
        <p class="overview"><a href="#">${Dvo.overview}</a></p>
      </div>
    </div>
  </c:if>
</c:forEach>

