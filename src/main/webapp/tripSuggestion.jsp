  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <%@ page import="java.util.Date" %>
  <%@ page import="mybatis.vo.DataVO" %>
  <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

  <!DOCTYPE html>


  <html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대한민국 구석구석 - 한국관광공사</title>
    <link rel="stylesheet" href="./css/style.css">
  </head>
  <body>

  <header>
    <div class="container header-top">
      <div class="text-right">
        <a href="#">로그인</a>
        <a href="#">회원가입</a>
        <a href="#">마이 페이지</a>
        <a href="#">고객센터</a>
      </div>
    </div>
    <div class="container header-main flex-between">
      <a href="#" class="logo">👋🏻 toour</a>
      <div class="search-area">
        <input type="text" placeholder="어디로 떠나고 싶으신가요?" />
        <i class="fas fa-search"></i>
      </div>

    </div>
  </header>

  <nav class="main-nav">
    <div class="container">
      <ul>
        <li><a href="#">홈</a></li>
        <li><a href="#">공지사항</a></li>
        <li><a href="#">지역</a></li>
        <li><a href="#">여행코스</a></li>
        <li><a href="Controller?type=tripSuggestion">여행정보</a></li>
        <li><a href="#">게시판</a></li>
      </ul>
    </div>
  </nav>
  <%--바디 영역--%>
  <h2 class="tag">#테마를 선택</h2>

  <div id="content_check">
      <a href="Controller?type=tripSuggestion&contentTypeId=}" id="contentType" data-vale="12">관광지</a>
      <a href="#" id="contentType" data-vale="14">문화시설</a>
      <a href="#" id="contentType" data-vale="15">축제공연/행사</a>
      <a href="#" id="contentType" data-vale="25">여행코스</a>
      <a href="#" id="contentType" data-vale="28">레포츠</a>
      <a href="#" id="contentType" data-vale="32">숙박</a>
      <a href="#" id="contentType" data-vale="38">쇼핑</a>
      <a href="#" id="contentType" data-vale="39">음식점</a>
  </div>

  <div id="main">
    <c:forEach var="Dvo" items="${requestScope.ar}" varStatus="count">
      <c:if test="${count.index < 5}">
      <div class="item">
    <img src="${Dvo.firstimage}" class="image" onclick="selectImage(this)">
        <div class="text ellipsis">
       <p class="title"><a href="#">${Dvo.title}</a></p>
        <p class="addr1"><a href="#">[${Dvo.addr1}]</a></p>
        <p class="overview"><a href="#">${Dvo.overview}</a></p>
      </div>
      </div>
      </c:if>
    </c:forEach>
  </div>

  <div id="page">
        <a href="#" class="on"id="1">1</a>
        <a href="#" class="on"id="2">2</a>
        <a href="#" class="on"id="3">3</a>
        <a href="#" class="on"id="4">4</a>
        <a href="#" class="on"id="5">5</a>
  </div>

  <footer>
    <div class="footer-news-ticker">
      <div class="container ticker-content">
        <span>[소식]2025년 강원 방문의 해! 7월의 추천 여행지 (동해안, 산악편)</span>
        <span class="ticker-controls">
                      <i class="fas fa-pause"></i>
                      <i class="fas fa-play"></i>
                      <i class="fas fa-plus"></i>
                  </span>
      </div>
    </div>
    <div class="container">
      <div class="footer-sns-links">
        <a href="#"><div class="sns-icon"><i class="fab fa-blogger-b"></i></div>블로그</a>
        <a href="#"><div class="sns-icon"><i class="fab fa-facebook-f"></i></div>페이스북</a>
        <a href="#"><div class="sns-icon"><i class="fab fa-twitter"></i></div>엑스</a>
        <a href="#"><div class="sns-icon"><i class="fas fa-comments"></i></div>카카오 스토리</a>
        <a href="#"><div class="sns-icon"><i class="fab fa-instagram"></i></div>인스타그램</a>
        <a href="#"><div class="sns-icon"><i class="fab fa-band"></i></div>네이버 밴드</a>
      </div>

      <div class="footer-banners">
        <div class="banner-item"><img src="https://via.placeholder.com/200x80?text=ODii" alt="오디 (ODii)"></div>
        <div class="banner-item"><img src="https://via.placeholder.com/200x80?text=Data+Request" alt="관광정보 수정/신청"></div>
        <div class="banner-item"><img src="https://via.placeholder.com/200x80?text=Wallpaper" alt="대한민국 구석구석 Wallpaper"></div>
        <div class="banner-item"><img src="https://via.placeholder.com/200x80?text=Travel+Guidebook" alt="여행 가이드북"></div>
        <div class="banner-item"><img src="https://via.placeholder.com/200x80?text=1330+Call" alt="전화/실시간 문자 채팅 상담 1330 관광안내"></div>
      </div>

      <nav class="footer-nav">
        <ul>
          <li><a href="#">개인정보처리방침</a></li>
          <li><a href="#">이용약관</a></li>
          <li><a href="#">위치기반서비스 이용약관</a></li>
          <li><a href="#">개인위치정보 처리방침</a></li>
          <li><a href="#">저작권정책</a></li>
          <li><a href="#">고객서비스헌장</a></li>
          <li><a href="#">전자우편무단수집거부</a></li>
          <li><a href="#">자주 묻는 질문</a></li>
          <li><a href="#">찾아오시는 길</a></li>
          <li><a href="#">사이트맵</a></li>
        </ul>
      </nav>
      <address class="text-center">
        (우)26464 강원특별자치도 원주시 세계로 10 한국관광공사
      </address>
      <p class="text-center contact-info">
        TEL : 033-738-3000 사업자등록번호 : 202-81-50707 통신판매신고 : 제2022-강원원주-0381호
      </p>
      <p class="copyright">
        &copy; 2025 Korea Tourism Organization. All Rights Reserved.
      </p>
    </div>
  </footer>

  <script>
    function selectImage(selectedImg) {
      let images = document.querySelectorAll('.images img');
      images.forEach(function(img) {
        img.classList.remove('selected');
        img.classList.add('deselected');
      });

      selectedImg.classList.remove('deselected');
      selectedImg.classList.add('selected');
    }
  </script>

  </body>
  </html>