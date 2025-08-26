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
    <div style="display: flex; position: relative;">
      <p><a href="javascript:showCourseList('${ar.courseDate_idx}', '${ar.date_title}', '${requestScope.course_name}')">${ar.date_title}(${ar.date})</a></p>
      <button type="button" id="deleteCourseDate" style="position: absolute; display: inline-block; background-color: #007bff; border: 0px; color: white; padding: 3px 10px; border-radius: 5px; font-size: 11px; height: 20px; margin-top: 2px; right: 0 " onclick="deleteCourseDate(${ar.courseDate_idx})">삭제</button>
    </div>
    <hr/>
  </c:forEach>
  <button type="button" id="backCourseDate" style="font-size: 11px; display: inline-block; position: absolute; right: 23.5px;
 background: #007bff !important;
            border: none !important;
            color: #fff !important;
            padding: 3px 10px !important;
            border-radius: 5px !important;
            cursor: pointer;
            margin-left: 8px !important;
            transition: background 0.2s ease;
            margin-top: 5px;

" class="buttonRight detail_btn" onclick="addCourse(1)">뒤로</button>
  <c:set var="course_idx" value="${requestScope.course_idx}"/>
  <input type="hidden" id="courseidxinput" value="${course_idx}">
</c:if>