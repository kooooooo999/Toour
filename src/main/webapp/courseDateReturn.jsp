<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${param.num eq 2}">
  <c:forEach items="${requestScope.date_ar}" var="ar" varStatus="vs">
    <p>${ar.date_title}(${ar.date})</p>
    <hr/>
  </c:forEach>
  <c:set var="course_idx" value="${requestScope.course_idx}"/>
  <input type="hidden" id="courseidxinput" value="${course_idx}">
  <div style="display: flex;" class="buttonBottom">
    <button type="button" id="backCourseDate" style="font-size: 12px; display: inline-block; position: absolute; right: 65px;" class="buttonRight detail_btn" onclick="addCourse(2)">뒤로</button>
    <button type="button" id="addCourseDate" style="font-size: 12px; display: inline-block;" class="buttonRight detail_btn" onclick="openDateTitle()">추가</button>
  </div>
</c:if>

<c:if test="${param.num eq 1}">
  <c:forEach items="${requestScope.date_ar}" var="ar" varStatus="vs">
    <p><a href="javascript:showCourseList('${ar.courseDate_idx}', '${ar.date_title}', '${requestScope.course_name}')">${ar.date_title}(${ar.date})</a></p>
    <hr/>
  </c:forEach>
  <button type="button" id="backCourseDate" style="font-size: 12px; display: inline-block; position: absolute; right: 15px;" class="buttonRight detail_btn" onclick="addCourse(1)">뒤로</button>
  <c:set var="course_idx" value="${requestScope.course_idx}"/>
  <input type="hidden" id="courseidxinput" value="${course_idx}">
</c:if>