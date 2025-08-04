
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <option value="0">::선택하시오::</option>
<%--시군구 select--%>
<c:forEach items="${requestScope.sigunguAr}" var="ar">
  <option value="${ar.code}">${ar.name}</option>
</c:forEach>
<%--cat1 select--%>
<c:forEach items="${requestScope.cat1Ar}" var="ar">
  <option value="${ar.code}">${ar.name}</option>
</c:forEach>
<%--cat2 select--%>
<c:forEach items="${requestScope.cat2Ar}" var="ar">
  <option value="${ar.code}">${ar.name}</option>
</c:forEach>
<%--cat3 select--%>
<c:forEach items="${requestScope.cat3Ar}" var="ar">
  <option value="${ar.code}">${ar.name}</option>
</c:forEach>