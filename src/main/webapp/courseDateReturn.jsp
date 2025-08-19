<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${requestScope.date_ar}" var="ar" varStatus="vs">
  <p><a href="">${ar.date_title}(${ar.date})</a></p>
  <hr/>
</c:forEach>
<button type="button" id="addCourseDate" style="font-size: 12px" class="buttonRight detail_btn buttonBottom" onclick="addCourseDate()">추가</button>