<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="mybatis.vo.DataVO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <style>
    #wrap{
        /*border: 1px solid #000;*/
        display: flex;
        position: relative;
        height: 600px;
    }
    #box{
      display: grid;
      grid-template-columns: 280px 280px;
      gap: 20px;
      width: 600px;
      margin: auto;
      /*border: 1px solid #4a545e;
      border-collapse: collapse;*/
      position: absolute;
      left: 880px;
      top: 50px;
    }
    #column{
        width: 250px;
    }
    #image{
      width: 250px;
      height: 150px;
    }
  </style>
</head>
<body>
<%--바디 영역--%>
<div id="wrap">
    <div id="box">
      <c:forEach var="vo" items="${requestScope.ar2}" varStatus="vs">
          <c:if test="${vs.index < 4}">
            <c:if test="${fn:length(vo.firstimage) > 0}">
            <div id="column">
                    <img id="image" src="${vo.firstimage}"/>
                    <p>${vo.addr1}</p>
                    <a href="#">${vo.title}</a>
            </div>
            </c:if>
          </c:if>
      </c:forEach>
    </div>
</div>

</body>
</html>