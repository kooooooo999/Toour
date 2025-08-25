<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기 - Toour</title>
    <link rel="stylesheet" href="<c:url value="/css/style.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <style>
        .find-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .find-title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 24px;
            font-weight: bold;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #1a73e8;
            box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2);
        }
        
        .find-button {
            width: 100%;
            padding: 14px;
            background: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-bottom: 20px;
        }
        
        .find-button:hover {
            background: #1557b0;
        }
        
        .result-message {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .result-message.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .result-message.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .back-links {
            text-align: center;
        }
        
        .back-links a {
            color: #1a73e8;
            text-decoration: none;
            margin: 0 10px;
        }
        
        .back-links a:hover {
            text-decoration: underline;
        }
        
        .info-box {
            background: #e7f3ff;
            border: 1px solid #b3d9ff;
            color: #0066cc;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="find-container">
        <h1 class="find-title">비밀번호 찾기</h1>
        
        <div class="info-box">
            가입 시 입력한 아이디, 이름, 이메일을 입력하시면<br>
            임시 비밀번호를 이메일로 발송해드립니다.
        </div>
        
        <c:if test="${not empty success}">
            <div class="result-message ${success ? 'success' : 'error'}">
                ${message}
            </div>
        </c:if>
        
        <form action="Controller?type=findPassword" method="post">
            <div class="form-group">
                <label for="member_id">아이디</label>
                <input type="text" id="member_id" name="member_id" required>
            </div>
            
            <div class="form-group">
                <label for="member_name">이름</label>
                <input type="text" id="member_name" name="member_name" required>
            </div>
            
            <div class="form-group">
                <label for="member_email">이메일</label>
                <input type="email" id="member_email" name="member_email" required>
            </div>
            
            <button type="submit" class="find-button">임시 비밀번호 발급</button>
        </form>
        
        <div class="back-links">
            <a href="Controller?type=moveLogin">로그인으로 돌아가기</a>
            <a href="Controller?type=moveSignup">회원가입</a>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
