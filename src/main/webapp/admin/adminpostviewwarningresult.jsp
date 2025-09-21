
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${requestScope.reportstatus > 0}">
  처리성공
</c:if>
<c:if test="${requestScope.reportstatus < 1}">
  처리실패
</c:if>