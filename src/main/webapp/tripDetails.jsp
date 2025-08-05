<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="toour.tripsuggestion.vo.DataVO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>👋🏻toour</title>
  <link rel="stylesheet" href="<c:url value="/css/header.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
  <link rel="stylesheet" href="<c:url value="/css/style.css" />">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

  <style>
    .overview {
      width: 650px;
      height: 120px;
      overflow: hidden;
      display: -webkit-box;
      -webkit-line-clamp: 5; /* 최대 5줄까지 표시 */
      -webkit-box-orient: vertical; /* 텍스트를 세로로 쌓기 */
      text-overflow: ellipsis; /* 넘치는 텍스트에 ... 표시 */
    }
  </style>

</head>
<body>

<c:import url="/common/header.jsp" />


<div id="main">
  <c:set var="Dvo" value="${requestScope.}"
      <img src="${Dvo.firstimage}" class="imageDetail">
      <i class="fa-solid fa-heart"></i>
      <div class="text ellipsis item">
        <p class="title"><a href="Controller?type=tripDetails">${Dvo.title}</a></p>
        <p class="addr1"><a href="Controller?type=tripDetails">[${Dvo.addr1}]</a></p>
        <p class="overview"><a href="Controller?type=tripDetails">${Dvo.overview}</a></p>
      </div>
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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>


</script>

</body>
</html>