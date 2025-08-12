<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="courseGrid">
  <c:forEach var="Dvo" items="${requestScope.dataAr}" varStatus="count">
    <a href="#" class="data-link" data-title="${Dvo.title}" data-addr1="${Dvo.addr1}" data-overview="${Dvo.overview}" data-firstimage="${Dvo.firstimage}" data-mapx="${Dvo.mapx}" data-mapy="${Dvo.mapy}" data-contentid="${Dvo.contentId}" data-homepageurl="${Dvo.homepageUrl}" data-homepagetext="${Dvo.homepageText}">
      <div class="courseBox">
        <div class="courseImage">
          <c:if test="${not empty Dvo.firstimage}">
            <img src="${Dvo.firstimage}">
          </c:if>
          <c:if test="${empty Dvo.firstimage}">
            [이미지없음]
          </c:if>
        </div>
        <div class="courseText">
          <h4>${Dvo.title}</h4>
        </div>
      </div>
    </a>
  </c:forEach>
  <input type="hidden" value="25" name="contentTypeId" id="contentTypeId"/>
</div>

