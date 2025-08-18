<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 14.
  Time: 오후 4:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>1:1 문의하기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
        }
        .container {
            width: 600px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-top: 10px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], select, textarea {
            margin-top: 5px;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        textarea {
            resize: vertical;
            height: 150px;
        }
        input[type="file"] {
            margin-top: 5px;
        }
        .btn-group {
            margin-top: 20px;
            text-align: center;
        }
        .btn-group input {
            padding: 10px 20px;
            margin: 0 10px;
            font-size: 14px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
        }
        .btn-submit {
            background-color: #4CAF50;
            color: white;
        }
        .btn-reset {
            background-color: #f44336;
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>1:1 문의하기</h2>
    <form action="" method="post" enctype="multipart/form-data">
        <label for="member_nickname">작성자 이름</label>
        <input type="text" id="member_nickname" name="member_nickname" value="<%= session.getAttribute("userNickName") != null ? session.getAttribute("userNickName") : "" %>" required>

        <label for="member_email">이메일</label>
        <input type="email" id="member_email" name="member_email" value="<%= session.getAttribute("userEmail") != null ? session.getAttribute("userEmail") : "" %>" required>

        <label for="category_idx">문의 유형</label>
        <select id="category_idx" name="category_idx" required>
            <option value="">--문의 유형 선택--</option>
            <option value="member_idx">계정 관련</option>
            <option value="service">서비스 이용</option>
            <option value="etc">기타</option>
        </select>

        <label for="title">제목</label>
        <input type="text" id="title" name="title" required>

        <label for="content">내용</label>
        <textarea id="content" name="content" required></textarea>

        <label for="file">첨부파일</label>
        <input type="file" id="file" name="file">

        <div class="btn-group">
            <input type="submit" value="문의 등록" class="btn-submit">
            <input type="reset" value="취소" class="btn-reset">
        </div>
    </form>
</div>
</body>
</html>
