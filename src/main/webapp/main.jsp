<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Visit Korea</title>
  <style>
    body{
      margin: 0;
      font-family: Arial,sans-serif;
    }

    .bar{
      background-color: #fff;
      border-bottom: 1px solid #ddd;
      padding: 10px 0;
      position: relative;
    }

    .menu{
      list-style: none;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      font-weight: 700;
      gap: 60px;
      position: relative;
    }

    .menu li{
      position: relative;
    }

    .menu a {
      text-decoration: none;
      color: #333333;
      font-size: 22px;
      padding: 10px 5px;
      display: inline-block;
      position: relative;
    }


    .menu a.act::after  {
      content: '';
      position: absolute;
      left: 0;
      bottom: 0;
      width: 0;
      height: 2px;
      background-color: #007BFF;
      transition: width 0.3s ease;
    }

    .menu a.act:hover::after{
      width: 100%;
    }


    .submenu{
      list-style: none;
      position: absolute;
      top: 100%;
      left: 0;
      background: #ffffff;
      border: 1px solid #ddd;
      display: none;
      padding: 10px 0;
      min-width: 150px;
      z-index: 10;
      gap: 10px;
      white-space: nowrap;
    }


    .submenu li {
      padding: 0;
    }

    .submenu a {
      font-size: 18px;
      font-weight: 600;
      padding: 8px 20px;
      color: #666666;
      text-decoration: none;
      position: relative;
    }

    .submenu a:hover{
      color: #007BFF ;
    }

    .submenu a::after {
      content: '';
      position: absolute;
      left: 0;
      bottom: -2px;
      width: 0;
      height: 2px;
      background-color: #007bff;
    }

    .submenu a:hover::after{
      width: 100%;
    }

    .dropdown:hover .submenu{
      display: flex;
    }
  </style>
  <link rel="stylesheet" href="css/styles.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- 헤더 -->
<header>
  <div class="logo">
    <span>Visit Korea</span>
  </div>

  <nav class = "bar">

    <ul class = "menu">
      <li class="dropdown">
        <a href="" class = "act">홈</a>
      </li>
    <li class="dropdown">
      <a href="#" class="act">관광지</a>
      <ul class="submenu">
        <li><a href="#">관광</a> </li>
        <li><a href="#">관광</a> </li>
        <li><a href="#">관광</a> </li>
        <li><a href="#">관광</a> </li>
        <li><a href="#">관광</a> </li>
        <li><a href="#">관광</a> </li>
      </ul>
    </li>
    <li class="dropdown">
      <a href="#" class="act">맛집</a>
      <ul class="submenu">
        <li><a href="#">맛집</a> </li>
        <li><a href="#">맛집</a> </li>
        <li><a href="#">맛집</a> </li>
        <li><a href="#">맛집</a> </li>
        <li><a href="#">맛집</a> </li>
        <li><a href="#">맛집</a> </li>
      </ul>
    </li>
    <li class="dropdown">
      <a href="#" class="act">추천코스</a>
      <ul class="submenu">
        <li><a href="#">계획</a></li>
        <li><a href="#">계획</a></li>
        <li><a href="#">계획</a></li>
        <li><a href="#">계획</a></li>
        <li><a href="#">계획</a></li>
      </ul>
    </li>
    <li class="dropdown">
      <a href="#" class="act">게시판</a>
      <ul class="submenu">
        <li><a href="#">후기</a></li>
        <li><a href="#">후기</a></li>
        <li><a href="#">후기</a></li>
        <li><a href="#">후기</a></li>
        <li><a href="#">후기</a></li>
      </ul>
    </li>

    </ul>
  </nav>
</header>

<!-- 메인 배너 -->
<section class="main-banner">
  <div class="banner-content">
    <h1>한국 여행을 시작하세요</h1>
    <p>아름다운 자연과 역사를 만날 수 있는 여행지</p>
    <a href="#" class="cta-btn">여행지 더 알아보기</a>
  </div>
</section>

<!-- 콘텐츠 섹션 -->
<section class="content">
  <h2>추천 여행지</h2>
  <div class="content-cards">
    <div class="card">
      <div class="card-title">서울</div>
      <p>서울은 전통과 현대가 조화를 이루는 도시입니다.</p>
    </div>
    <div class="card">
      <div class="card-title">제주도</div>
      <p>자연과 휴식을 동시에 즐길 수 있는 제주도!</p>
    </div>
    <div class="card">
      <div class="card-title">경주</div>
      <p>경주는 역사와 문화가 가득한 도시입니다.</p>
    </div>
  </div>
</section>

<!-- 푸터 -->
<footer>
  <p>© 2025 Visit Korea. All Rights Reserved.</p>
</footer>

<script src="script.js"></script>
<script>

  $(document).ready(function() {
    console.log("Visit Korea site loaded.");
  });

</script>
</body>
</html>
