<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 코스추가 눌렀을 때 조회 --%>
<c:if test="${param.number eq '2'}">
  <c:set var="member_idx" value="${requestScope.member_idx}"/>
  <input id="member_idx" type="hidden" value="${requestScope.member_idx}">
  <button type="button" style="font-size: 12px; width: 70px;" id="openCourseList" class="buttonRight detail_btn buttonBottom" onclick="openCourseList(${member_idx})">여행 추가</button>
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
    <p><a href="javascript:myCourseDate('${ar.course_idx}', '${ar.course_name}')">${ar.course_name}</a></p>
    <hr/>
  </c:forEach>
</c:if>