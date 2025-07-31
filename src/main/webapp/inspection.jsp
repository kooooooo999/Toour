
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



    <p>${requestScope.alertText}</p>
    <c:if test="${requestScope.usable eq 'false'}" >
    <input type="hidden" id="disable">
    </c:if>