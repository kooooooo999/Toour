<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="mybatis.vo.DataVO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <style>
    #column{
      display: grid;
      grid-template-columns: 220px 220px;
      grid-template-rows: 120px 120px;
      /*width: 220px;
      height: 120px;*/
      border: 1px solid #4a545e;
      border-collapse: collapse;
    }
    #image{
      width: 200px;
      height: 100px;
    }
  </style>
</head>
<body>
<%--바디 영역--%>
<div id="column">
    <c:forEach var="vo" items="${requestScope.ar}" varStatus="vs">
      <c:if test="${fn:length(vo.firstimage2) > 0}">
          <img id="image" src="${vo.firstimage2}"/>
          <a href="#">${vo.title}</a>
    </c:if>

  </c:forEach>
</div>


</body>
</html>