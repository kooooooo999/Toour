<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="member_idx" value="${requestScope.member_idx}"/>
<button type="button" style="font-size: 12px" id="addCourseList" class="buttonRight detail_btn buttonBottom" onclick="addCourseList(${member_idx})">여행 추가</button>
<c:forEach items="${requestScope.course_ar}" var="ar" varStatus="vs">
  <p><a href="javascript:courseDate(${ar.course_idx})">${ar.course_name}</a></p>
  <hr/>
</c:forEach>