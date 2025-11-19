<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 1.
  Time: 오후 4:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="toour.util.ApiKeyUtil" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="http://apis.data.go.kr/B551011/KorService2/categoryCode2?<%= ApiKeyUtil.getServiceKeyParam(ApiKeyUtil.getBoKey()) %>&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest"></a>

</body>
</html>
