<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="toour.tripsuggestion.vo.DataVO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <style>
    #city{
        display: inline-block;
        width: 600px;
        height: 600px;
        /*border: 1px solid #000;*/
        <c:if test="${param.imageChange == null}">
            background-image: url("images/total.png");
        </c:if>
        <c:if test="${param.imageChange ne null}">
            background-image: url("images/${param.imageChange}.png");
        </c:if>
        background-repeat: no-repeat;
        margin: auto;
        position: relative;
    }
    #box{
      display: grid;
      grid-template-columns: 280px 280px;
      gap: 30px;
      width: 500px;
      margin-left: 50px;
      padding-top: 25px;
      /*border: 1px solid #4a545e;
      border-collapse: collapse;*/
    }
    #column{
        width: 250px;
    }
    #image{
      width: 250px;
      height: 150px;
    }
    .ellip{ margin-top: 10px; font-weight: bold; display: inline-block; width: 100%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
  </style>
</head>
<body>
<%--바디 영역--%>
    <div id="box">
        <c:forEach var="vo" items="${requestScope.ar2}" varStatus="vs">
            <c:if test="${vs.index < 4}">
                <c:if test="${fn:length(vo.firstimage) > 0}">   <div id="column">
                    <img id="image" src="${vo.firstimage}"
                        onerror="this.src='images/noImage.png'"/>
                    <p class="ellip">${vo.addr1}</p>
                    <a href="#" class="ellip">${vo.title}</a>
                </div>
                </c:if>
            </c:if>
        </c:forEach>
    </div>
</body>
</html>