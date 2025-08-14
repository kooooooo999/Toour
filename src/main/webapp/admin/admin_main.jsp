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

        .dashboard {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2열 */
            gap: 20px; /* 카드 사이 간격 */
            padding: 20px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }

        .card2 {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }

        .card-title {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        .card-title small {
            font-size: 13px;
            color: #7f8c8d;
        }

        .today_visit{
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        .today_board{
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        .today_warning{
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }



    </style>
</head>
<body>

<div class="sidebar">

    <!-- 메뉴 -->
    <a href="AdminController">🏠 HOME</a>
    <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
    <a href="AdminController?type=adminpost">📝 게시물 관리</a>
    <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
</div>

<div class="main-content">
    <h1>관리자 페이지</h1>
</div>

<div class="dashboard">
    <div class="card">
        <div class="card-title">
            전체 회원 수<br>
            <small>(전체회원수 / 휴면회원수 / 탈퇴회원수 / 강퇴회원수)</small>
        </div>
    </div>
    <div class="card">
        <div class="today_visit">
            오늘 방문자 수
        </div>
    </div>
    <div class="card2">
        <div class="today_board">
            오늘 게시글 수
        </div>
    </div>
    <div class="card2">
        <div class="today_warning">
            최근 신고 수 (한달)
        </div>
    </div>

</div>
</body>
</html>
