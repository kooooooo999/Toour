<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>


<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>👋🏻toour</title>
    <link rel="stylesheet" href="<c:url value="/css/style.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <link rel="stylesheet" href="<c:url value="/css/sido.css" />">
</head>
<body>
<c:import url="/common/header.jsp" />
<%
    System.out.println("index");
%>
<main>
    <section class="hero-travel-guide container">
        <div class="hero-content-left">
            <small>선비의 발자취를 따라,</small>
            <h2>아이와 함께 떠나는<br>경북 영주 여행지 3</h2>
            <p>유유자적 고즈넉한 한옥의 정취를 느끼며 전통문화와 자연을 체험하는 경북 영주 여행 코스</p>
            <a href="#" class="detail-btn">자세히 보기</a>
            <div class="hero-pagination">
                <span>06 / 11</span>
                <i class="fas fa-caret-left arrow"></i>
                <i class="fas fa-caret-right arrow"></i>
            </div>
        </div>
        <div class="hero-image-right">
<%--            <img src="https://via.placeholder.com/600x400/d7e5f0/4e6e8e?text=Gyeongju+Travel+Image" alt="경북 영주 여행 이미지">--%>
        </div>
    </section>
    <div id="sidoDiv">
    <jsp:include page="./sido.jsp"/>
    </div>
    <section class="travel-cockcock">
        <div class="container">
            <div class="section-header">
                <h3>여행콕콕</h3>
                <p>빅데이터 기반 AI 추천 여행지와 코스를 알려드려요.</p>
            </div>
            <div class="tabs">
                <button class="active">AI콕콕</button>
                <button>핫플콕콕</button>
                <button>AI콕콕 플래너</button>
            </div>
            <div class="recommend-cards">
                <div class="card">
                    <img src="#" alt="노도(김만중)">
                    <div class="card-content">
                        <h4>노도(김만중)<br><small>경상남도 남해군</small></h4>
                        <p>섬 전체가 하나의 거대한 문학 공원</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="card">
                    <img src="#" alt="취한대">
                    <div class="card-content">
                        <h4>취한대<br><small>경상남도 하동군</small></h4>
                        <p>지리산 산자락에 위치한 고즈넉한 정자</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="card">
                    <img src="#" alt="산의한우마을">
                    <div class="card-content">
                        <h4>산의한우마을<br><small>전라북도 진안군</small></h4>
                        <p>싱싱한 한우를 맛볼 수 있는 한우거리</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="card">
                    <img src="#" alt="대구 등산">
                    <div class="card-content">
                        <h4>대구 히스토리...<br><small>대구광역시 북구</small></h4>
                        <p>대구의 역사와 문화를 느낄 수 있는 곳</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
            </div>
            <a href="#" class="more-button">오늘의 AI콕콕 추천 더보기 <i class="fas fa-plus"></i></a>
        </div>
    </section>

    <section class="news-banner-section container">
        <div class="news-area">
            <h3>오늘의 여행 소식 <i class="fas fa-plus plus-icon"></i></h3>
            <ul class="news-list">
                <li>
                    <span class="category">행정안전부</span>
                    <span class="news-title">폭염 대비 국민 행동 요령! 이것만은 꼭 지키자!</span>
                    <span class="news-date">2025.07.29</span>
                </li>
                <li>
                    <span class="category">한국관광공사</span>
                    <span class="news-title">'2025 대한민국 밤밤 페스타' 전국 개막</span>
                    <span class="news-date">2025.07.28</span>
                </li>
                <li>
                    <span class="category">강원특별자치도</span>
                    <span class="news-title">2025 Tour de DMZ 고성 그란폰도 개최</span>
                    <span class="news-date">2025.07.27</span>
                </li>
                <li>
                    <span class="category">해양수산부</span>
                    <span class="news-title">제11회 섬 여행 영상 공모전</span>
                    <span class="news-date">2025.07.26</span>
                </li>
            </ul>
        </div>

    </section>

    <section class="healing-travel-section container section-padding">
        <h3 class="section-title">함께 떠나는 힐링테마 여행</h3>
        <div class="healing-carousel-wrapper">
            <div class="healing-card-wrapper">
                <div class="healing-card">
                    <img src="#" alt="경주 풍력발전소">
                    <div class="card-content">
                        <h4>일출 명소부터 짜릿한 체험까지!</h4>
                        <p>경주에서 보내는 특별한 하루</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="healing-card">
                    <img src="#" alt="전남 미식 여행">
                    <div class="card-content">
                        <h4>입안 가득 바다의 맛 🎣</h4>
                        <p>전남 미식 여행 코스 추천</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="healing-card">
                    <img src="#" alt="서울 걷기 명소">
                    <div class="card-content">
                        <h4>낭만 치사랑 한도 초과💖</h4>
                        <p>서울 경기 능소화 명소 4</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="healing-card">
                    <img src="#" alt="서울 트리하우스">
                    <div class="card-content">
                        <h4>그늘 아래 휴식 한 스푼 🌳</h4>
                        <p>서울 근교 트리하우스 명소 4</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
            </div>
            <div class="healing-navigation">
                <i class="fas fa-chevron-right"></i>
            </div>
        </div>
        <div class="healing-pagination-dots">
            <span>1 / 3</span>
        </div>
    </section>
</main>

<c:import url="/common/footer.jsp" />

</body>

</html>