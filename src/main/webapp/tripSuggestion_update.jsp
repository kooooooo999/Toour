  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <div id="main_2">
      <c:forEach var="Dvo" items="${requestScope.dataAr}" varStatus="count">
          <c:if test="${count.index < 5}">
              <img src="${Dvo.firstimage}" class="image">
              <div class="text ellipsis item">
                  <p class="title"><a href="#">${Dvo.title}</a></p>
                  <p class="addr1"><a href="#">[${Dvo.addr1}]</a></p>
                  <p class="overview"><a href="#">${Dvo.overview}</a></p>
              </div>
          </c:if>
      </c:forEach>
  </div>

