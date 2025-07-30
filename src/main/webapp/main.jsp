<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관광지 안내</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<!-- 상단 메뉴바 -->
<header>
  <nav>
    <ul>
      <li><a href="#">홈</a></li>
      <li><a href="#">관광지 소개</a></li>
      <li><a href="#">이용 방법</a></li>
      <li><a href="#">연락처</a></li>
    </ul>
  </nav>
</header>

<!-- 중단 이미지 공간 -->
<section id="image-section">
  <div class="image-container">
    <img src="${pageContext.request.contextPath}/images/tourism_image.jpg" alt="관광지 이미지">
  </div>
</section>

<!-- 하단 회사 정보 -->
<footer>
  <div class="footer-content">
    <p>&copy; 2025 관광지 안내 | 회사 주소: 서울시 강남구</p>
    <p>전화: 02-1234-5678 | 이메일: contact@tourism.com</p>
  </div>
</footer>
</body>
</html>
