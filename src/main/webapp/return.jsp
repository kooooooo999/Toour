<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
#city{
  display: inline-block;
  width: 500px;
  height: 600px;
  /*border: 1px solid #000;*/
  <c:if test="${param.imageChange==null}">
    background-image: url("images/total.png");
  </c:if>
  <c:if test="${param.imageChange ne null}">
    background-image: url("images/${param.imageChange}.png");
  </c:if>
  background-repeat: no-repeat;
  position: absolute;
  left: 300px;
}