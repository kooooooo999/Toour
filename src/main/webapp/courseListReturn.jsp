<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 코스추가 눌렀을 때 조회 --%>
<c:if test="${param.number eq '2'}">
  <c:set var="member_idx" value="${requestScope.member_idx}"/>
  <input id="member_idx" type="hidden" value="${requestScope.member_idx}">
  <button type="button" style="font-size: 12px; width: 70px; position: absolute; right: 15px;" id="openCourseList" class="buttonRight detail_btn buttonBottom" onclick="openCourseList(${member_idx})">여행 추가</button>
  <c:forEach items="${requestScope.course_ar}" var="ar" varStatus="vs">
    <p><a href="javascript:courseDate(${ar.course_idx})">${ar.course_name}</a></p>
    <hr/>
  </c:forEach>
</c:if>

<%-- 내코스에서 조회 --%>
<c:if test="${param.number eq 1}">
  <c:set var="member_idx" value="${requestScope.member_idx}"/>
  <input id="member_idx" type="hidden" value="${requestScope.member_idx}">
  <c:forEach items="${requestScope.course_ar}" var="ar" varStatus="vs">
    <div style="display: flex; position: relative;">
      <p><a href="javascript:myCourseDate('${ar.course_idx}', '${ar.course_name}')" style="display: inline-block">${ar.course_name}</a></p>
      <button type="button" id="deleteCourse" style="position: absolute; display: inline-block; background-color: #007bff; border: 0px; color: white; padding: 3px 10px; border-radius: 5px; font-size: 11px; height: 20px; margin-top: 2px; right: 0 " onclick="totalDeleteCourse(${ar.course_idx})">삭제</button>
    </div>
    <hr/>
  </c:forEach>
</c:if>