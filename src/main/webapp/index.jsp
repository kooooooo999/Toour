<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <style>
        #table{
            border-collapse: collapse;
        }
        #table caption{
            text-indent: -9999px;
            height: 0;
        }
        #table td{
            border: 1px solid #000;
        }
    </style>
</head>
<body>
 <button onclick="location.href='Controller?type=signup'">회원가입</button>
 <button onclick="location.href='Controller?type=login'">로그인</button>



</body>
</html>