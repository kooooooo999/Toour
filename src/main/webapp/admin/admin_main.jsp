<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <style>
        body {
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
            display: flex;
            background-color: #f4f6f8;
        }

        .sidebar {
            width: 220px;
            background-color: #2c3e50;
            display: flex;
            flex-direction: column;
            padding: 20px;
            color: white;
            height: 100vh;
        }

        .sidebar a {
            text-decoration: none;
            color: white;
            padding: 12px 10px;
            border-bottom: 1px solid #34495e;
            transition: background-color 0.3s;
        }

        .sidebar a:hover {
            background-color: #34495e;
        }

        .main-content {
            flex: 1;
            padding: 40px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 6px;
            overflow: hidden;
        }

    </style>
</head>
<body>

<div class="sidebar">

    <!-- 메뉴 -->
    <a href="AdminController">🏠 HOME</a>
    <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
    <a href="AdminController?type=adminpost">📝 게시물 관리</a>
    <a href="product_list.jsp?category=sp003">🍽 관광지/맛집 관리</a>
    <a href="product_list.jsp?category=sp003">🗺 관광코스 관리</a>
    <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
</div>

<div class="main-content">
    <h1>관리자 페이지</h1>
    <p>대시보드.</p>
</div>

</body>
</html>
