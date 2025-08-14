<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:forEach items="${requestScope.courseList}" var="list" varStatus="vs">
    <div id="course">
        <div style="display: inline-block;">
            <button type="button" class="minusButton" onclick="removeList('${list.title}',${vs.index})"></button>
            <p class="ellip" style="display: inline-block;">${list.title}(${vs.index+1})</p>
            <p class="ellip" style="display: block; font-weight: bold; font-size: 10px; color: #6c757d">${list.addr1}</p>
        </div>
    </div>
        <c:if test="${fn:length(requestScope.courseList) != (vs.index+1)}">
            <hr style="margin-top: 13px;" color="#eee" size="1px" width="260px;"/>
        </c:if>
</c:forEach>
<input type="hidden"  id="courseList" value="${requestScope.courseList}"/>