<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<c:url value="/css/style.css" />">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />

<header>
  <div class="container header-top">
    <div class="text-right">
      <c:if test="${sessionScope.user eq null}">
        <a href="Controller?type=moveLogin">로그인</a>
        <a href="Controller?type=moveSignup">회원가입</a>
      </c:if>
      <c:if test="${sessionScope.user ne null}">
        <a href="Controller?type=login">로그아웃</a>
      </c:if>
      <a href="Controller?type=mypage">마이 페이지</a>
      <a href="#">고객센터</a>
    </div>
  </div>
  <div class="container header-main flex-between">
    <a href="Controller" class="logo">👋🏻 toour</a>
    <form id="search_form" accept-charset="UTF-8" method="post">
      <input id="keyword" type="text" placeholder="어디로 떠나고 싶으신가요?" name="keyword"/>
      <i class="fas fa-search"></i>
    </form>
  </div>

  <!-- 여기서부터 Swiper 메뉴 -->
  <div class="menu">
    <div class="depth1">
      <div class="swiper-container">
        <ul class="swiper-wrapper">
          <li class="swiper-slide on" onclick="changetab('/main/main.do','all');"><a href="/main/main.do">홈</a></li>
          <li class="swiper-slide" onclick="changetab('/main/theme.do','all');"><a href="/main/theme.do">테마</a></li>
          <li class="swiper-slide" onclick="changetab('/main/area.do','all');"><a href="/main/area.do">지역</a></li>
          <li class="swiper-slide" onclick="changetab('/list/travelcourse.do?service=cs','mobile');">
            <a href="javascript:;">여행코스</a>
            <div class="depth2 smenu1">
              <ul>
                <li id="top_menu_cs" onclick="changetab('/list/travelcourse.do?service=cs','all');"><a href="/list/travelcourse.do?service=cs">추천코스</a></li>
                <li id="top_menu_abc" onclick="changetab('/list/travelcourse.do?service=abc&amp;detailType=area','all');"><a href="/list/travelcourse.do?service=abc&amp;detailType=area">AI콕콕 플래너</a></li>
              </ul>
            </div>
          </li>
          <li class="swiper-slide" onclick="changetab('/list/travelinfo.do?service=ms','mobile');">
            <a href="javascript:;">여행정보</a>
            <div class="depth2 smenu2">
              <ul>
                <li id="top_menu_ms" onclick="changetab('/list/travelinfo.do?service=ms','all');"><a href="/list/travelinfo.do?service=ms">여행지</a></li>
                <li id="top_menu_rem" onclick="changetab('/list/travelinfo.do?service=rem','all');"><a href="/list/travelinfo.do?service=rem">여행기사</a></li>
                <li id="top_menu_fes" onclick="changetab('https://korean.visitkorea.or.kr/kfes/list/wntyFstvlList.do','all');"><a href="https://korean.visitkorea.or.kr/kfes/list/wntyFstvlList.do">축제</a></li>
                <li id="top_menu_show" onclick="changetab('/list/travelinfo.do?service=show','all');"><a href="/list/travelinfo.do?service=show">공연 / 행사</a></li>
                <li id="top_menu_ai" onclick="changetab('/list/travelinfo.do?service=ai','all');"><a href="/list/travelinfo.do?service=ai">AI콕콕</a></li>
                <li id="top_menu_tgpr" onclick="changetab('/list/travelinfo.do?service=tgpr','all');"><a href="/list/travelinfo.do?service=tgpr">여행상품</a></li>
              </ul>
            </div>
          </li>
          <li class="swiper-slide" onclick="changetab('/list/travelbenefit.do?service=event','mobile');">
            <a href="javascript:;">여행혜택</a>
            <div class="depth2 smenu2">
              <ul>
                <li id="top_menu_event" onclick="changetab('/list/travelbenefit.do?service=event','all');"><a href="/list/travelbenefit.do?service=event">이벤트</a></li>
                <li id="top_menu_trss" onclick="changetab('/list/travelbenefit.do?service=trss','all');"><a href="javascript:goListTrss()">가볼래-터</a></li>
                <li id="top_menu_cockcock" onclick="changetab('/rewardPage/','all');" style="display: none;"><a href="/rewardPage/">배지콕콕</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>

</header>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<script>
  // 검색 엔터 처리
  $(function () {
    $('#keyword').on('keypress', function (e) {
      if (e.key === 'Enter') {
        e.preventDefault();
        const keyword = $(this).val().trim();
        if (keyword.length === 0) return;
        $('#search_form').submit();
        location.href = "Controller?type=searchKeyword&keyword=" + encodeURIComponent(keyword);
      }
    });
  });

  // Swiper 초기화
  const swiper = new Swiper('.swiper-container', {
    loop: false,
    slidesPerView: 'auto',
    freeMode: true,
    spaceBetween: 10,
    centeredSlides: false
  });

  // changetab 함수가 없으면 간단 구현
  function changetab(url, mode) {
    window.location.href = url;
  }
</script>
