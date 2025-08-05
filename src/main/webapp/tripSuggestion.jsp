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

          ol.paging {
              display: flex; /* flexbox로 가로 정렬 */
              padding: 0;
              justify-content: center; /* 가운데 정렬 */
              position: relative;
              top: 5px; /* 위쪽 여백 */
              margin-bottom: 50px; /* 아래쪽 여백 */
          }

          ol.paging li {
              list-style-type: none; /* 기본 번호를 제거 */
              margin-right: 12px; /* 각 항목 간의 간격 */
          }

          ol.paging li a {
              display: block;
              text-decoration: none;
              padding: 10px 20px;
              border: 2px solid #0056b3;
              color: #2f313e;
              font-weight: bold;
              border-radius: 5px;
              background-color: transparent;
              transition: background-color 0.3s, color 0.3s;
          }

          /* hover 시 배경색 변경 */
          ol.paging li a:hover {
              background-color: #0056b3;
              color: white;
          }

          /* 클릭한 항목의 색 변경 */
          ol.paging li a:focus {
              background-color: #0056b3;
              color: white;
              border: 2px solid #0056b3;
          }

          /* 비활성화된 페이지 항목 (현재 페이지) */
          .current {
              background-color: #0056b3;
              color: white;
              pointer-events: none; /* 클릭 불가 */
              border: 2px solid #0056b3; /* 활성화된 페이지는 동일 색 */
              display: block;
              text-decoration: none;
              padding: 10px 20px;
              font-weight: bold;
              border-radius: 5px;
              transition: background-color 0.3s, color 0.3s;
          }

          ol.paging li a.disable {
              background-color: transparent;
              color: silver;
              border: 2px solid silver;
              pointer-events: none; /* 클릭 불가 */
              display: none; /* 요소를 완전히 숨기기 */
          }
          ol.paging li.disable {
              display: none; /* li 태그 자체를 숨김 (a 태그도 포함) */
          }
      </style>

  </head>
  <body>

  <c:import url="/common/header.jsp" />


  <%--바디 영역--%>

  <h2 class="tag">#테마를 선택</h2>

  <div id="content_check">
      <a href="#" class="contentTypeId" data-value="12">관광지</a>
      <a href="#" class="contentTypeId" data-value="14">문화시설</a>
      <a href="#" class="contentTypeId" data-value="15">축제공연/행사</a>
      <a href="#" class="contentTypeId" data-value="25">여행코스</a>
      <a href="#" class="contentTypeId" data-value="28">레포츠</a>
      <a href="#" class="contentTypeId" data-value="32">숙박</a>
      <a href="#" class="contentTypeId" data-value="38">쇼핑</a>
      <a href="#" class="contentTypeId" data-value="39">음식점</a>
  </div>
  <ol>
      <li>
          <select id="areaCode" name="areaCode">
              <option value="0">::선택하시오::</option>
              <option value="1">서울</option>
              <option value="2">인천</option>
              <option value="3">대전</option>
              <option value="4">대구</option>
              <option value="5">광주</option>
              <option value="6">부산</option>
              <option value="7">울산</option>
              <option value="31">경기도</option>
              <option value="32">강원도</option>
              <option value="33">충청북도</option>
              <option value="34">충청남도</option>
              <option value="35">경상북도</option>
              <option value="36">경상남도</option>
              <option value="37">전라북도</option>
              <option value="38">전라남도</option>
              <option value="39">제주도</option>
          </select>
      </li>
      <li>
          <select id="sigunguCode" name="sigunguCode">
              <option value="0">::선택하시오::</option>
          </select>
      </li>
      <li>
          <select id="cat1" name="cat1">
              <option value="0">::선택하시오::</option>
              <option value="A01">자연</option>
              <option value="A02">인문(문화/예술/역사)</option>
          </select>
      </li>
      <li>
          <select id="cat2" name="cat2">
              <option value="0">::선택하시오::</option>
          </select>
      </li>
      <li>
          <select id="cat3" name="cat3">
              <option value="0">::선택하시오::</option>
          </select>
      </li>
      <li>
          <button type="button">검색</button>
      </li>
  </ol>


  <div id="main">
    <c:forEach var="Dvo" items="${requestScope.dataAr}" varStatus="count">
      <c:if test="${count.index < 5}">
      <div class="item">
          <c:if test="${fn:length(Dvo.firstimage)>0 and fn:length(Dvo.title)>0 and
          fn:length(Dvo.addr2)>0 and fn:length(Dvo.overview)>0 and Dvo.contenttypeid != 25}">
        <img src="${Dvo.firstimage}" class="image" onclick="selectImage(this)">
            <div class="text ellipsis">
       <p class="title"><a href="#">${Dvo.title}</a></p>
        <p class="addr1"><a href="#">[${Dvo.addr1}]</a></p>
        <p class="overview"><a href="#">${Dvo.overview}</a></p>
            </div>
          </c:if>

          <c:if test="${fn:length(Dvo.firstimage)>0 and fn:length(Dvo.title)>0 and
          fn:length(Dvo.addr2)>0 and fn:length(Dvo.overview)>0 and Dvo.contenttypeid == 25}">
              <img src="${Dvo.firstimage}" class="image" onclick="selectImage(this)">
              <div class="text ellipsis">
                  <p class="title"><a href="#">${Dvo.title}</a></p>
                  <p class="overview"><a href="#">${Dvo.overview}</a></p>
              </div>
          </c:if>

      </div>
      </c:if>
    </c:forEach>
  </div>

  <div id="page">

              <ol class="paging">
                  <c:set var="p" value="${requestScope.page}" scope="page"/>

                  <c:if test="${p.startPage < p.pagePerBlock}">

                      <li class="disable">&lt;</li>
                  </c:if>

                  <c:if test="${p.startPage >= p.pagePerBlock}">

                      <li><a href="Controller?type=tripSuggestion&cPage=${p.nowPage-p.pagePerBlock}">&lt;</a></li>
                  </c:if>

                  <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
                      <c:if test="${p.nowPage == vs.index}">
                          <li class="current">${vs.index}</li>
                      </c:if>
                      <c:if test="${p.nowPage != vs.index}">
                          <li><a href="Controller?type=tripSuggestion&cPage=${vs.index}">${vs.index}</a></li>
                      </c:if>
                  </c:forEach>

                  <c:if test="${p.endPage < p.totalPage}">

                      <li><a href="Controller?type=tripSuggestion&cPage=${p.nowPage+p.pagePerBlock}">&gt;</a></li>
                  </c:if>
                  <c:if test="${p.endPage >= p.totalPage}">
                      <li class="disable">&gt;</li>
                  </c:if>

              </ol>
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
      $(function (){
      //contentTypeId = 12 관광지 로 기본선택 되어있기
          $("#areaCode").blur(function () {

              let areaCode = $("#areaCode").val();
              if(areaCode!=0) {
                  $.ajax({
                      url: "Controller?type=area",
                      method: "POST",
                      data: {areaCode: areaCode}
                  }).done(function (res) {
                      $("#sigunguCode").html(res);
                  });
              }
          });

          $("#cat1").blur(function (){
              let cat1 = $("#cat1").val();
              if(cat1!= 0) {
                  $.ajax({
                      url: "Controller?type=area",
                      method: "POST",
                      data: {cat1: cat1}
                  }).done(function (res) {
                      $("#cat2").html(res);
                      $("#cat3").html("<option value='0'>::선택하시오::</option>");

                  });
              }
          });

          $("#cat2").blur(function (){
              let cat1 = $("#cat1").val();
              let cat2 = $("#cat2").val();
              if(cat2!=0 && cat3!=0) {
                  $.ajax({
                      url: "Controller?type=area",
                      method: "POST",
                      data: {cat1: cat1,cat2: cat2}
                  }).done(function (res) {
                      $("#cat3").html(res);
                  });
              }
          });
      });

      $(".contentTypeId").on("click",function (value){
          value.preventDefault();
          let contentTypeId = $(this).data("value");
          let areaCode = $("#areaCode").val();
          let sigunguCode = $("#sigunguCode").val();
          let cat1 = $("#cat1").val();
          let cat2 = $("#cat2").val();
          let cat3 = $("#cat3").val();

          $.ajax({
              url: "Controller?type=tripSuggestion",
              method: "POST",
              data: {contentTypeId: contentTypeId , areaCode: areaCode , sigunguCode:sigunguCode,
                  cat1:cat1, cat2:cat2, cat3:cat3 /*, cPage:cPage */}
          }).done(function (res){
                $("#main").html(res);
          });

          $.ajax({
              url: "Controller?type=area",
              method: "POST",
              data: {contentTypeId: contentTypeId}
          }).done(function (res){
              $("#cat1").html(res);
              $("#cat2").html("<option value='0'>::선택하시오::</option>");
              $("#cat3").html("<option value='0'>::선택하시오::</option>");
          });

      });

  </script>

  </body>
  </html>