<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Visit Korea</title>
  <link rel="stylesheet" href="css/styles.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- 헤더 -->
<header>
  <div class="logo">
    <span>Visit Korea</span>
  </div>
  <nav>
    <ul>
      <li><a href="#">홈</a></li>
      <li><a href="#">여행지</a></li>
      <li><a href="#">문화</a></li>
      <li><a href="#">체험</a></li>
      <li><a href="#">한국의 아름다움</a></li>
      <li><a href="#">공지사항</a></li>
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
