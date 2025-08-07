  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <div id="main_2">
      <c:forEach var="Dvo" items="${requestScope.dataAr}" varStatus="count">
          <c:if test="${count.index < 5}">
              <div id="heartImage">
                  <p class="heartIcon">
                      <i class="fa-regular fa-heart" ></i>
                  </p>
              </div>
              <img src="${Dvo.firstimage}" class="image">
              <div class="text ellipsis item">
                  <p class="title"><a href="#" class="data-link" data-title="${Dvo.title}" data-addr1="${Dvo.addr1}" data-overview="${Dvo.overview}" data-firstimage="${Dvo.firstimage}">${Dvo.title}</a></p>
                  <p class="addr1"><a href="#" class="data-link" data-title="${Dvo.title}" data-addr1="${Dvo.addr1}" data-overview="${Dvo.overview}" data-firstimage="${Dvo.firstimage}">${Dvo.addr1}</a></p>
                  <p class="overview"><a href="#" class="data-link" data-title="${Dvo.title}" data-addr1="${Dvo.addr1}" data-overview="${Dvo.overview}" data-firstimage="${Dvo.firstimage}">${Dvo.overview}</a></p>
              </div>
          </c:if>
          <input type="hidden" name="Dvo${count.index}" value="${Dvo}">
      </c:forEach>
  </div>

