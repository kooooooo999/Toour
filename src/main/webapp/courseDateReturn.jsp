<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${requestScope.date_ar}" var="ar" varStatus="vs">
  <p><a href="">${ar.date_title}(${ar.date})</a></p>
  <hr/>
</c:forEach>
<c:set var="course_idx" value="${requestScope.date_ar[0].course_idx}"/>
<input type="hidden" id="courseidxinput" value="${course_idx}">
<div style="display: flex;" class="buttonBottom">
  <button type="button" id="backCourseDate" style="font-size: 12px; display: inline-block;" class="buttonRight detail_btn" onclick="addCourse()">뒤로</button>
  <button type="button" id="addCourseDate" style="font-size: 12px; display: inline-block; position: absolute; right: 65px;" class="buttonRight detail_btn" onclick="openDateTitle()">추가</button>
</div>