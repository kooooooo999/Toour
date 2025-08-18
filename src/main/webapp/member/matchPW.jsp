
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${requestScope.bol eq true}">
  <p>true</p>
</c:if>
<c:if test="${requestScope.bol eq false}">
  <p>false</p>
</c:if>