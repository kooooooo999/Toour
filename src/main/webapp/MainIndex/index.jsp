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
                <h3><strong>추천코스</strong></h3>
                <p>빅데이터 기반 AI 추천 여행지 코스를 알려드려요.</p>
            </div>

            <div class="tabs">
                <button class="tab active">AI콕콕</button>
                <button class="tab">핫플콕콕</button>
                <button class="tab">AI콕콕 플래너</button>
            </div>

            <div class="ai-intro">
                <p>당신의 성향, 취향 분석 완료! 마음에 쏙 들 여행지를 추천해 드릴게요.</p>
                <p>  　</p>
            </div>

            <div class="recommend-cards">
                <div class="card">
<<<<<<< HEAD
                    <img src="#" alt="노도(김만중)">
=======
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=5479400c-1531-4197-a861-0dd37bc1603a" alt="덕가산">
>>>>>>> origin/feature_sebin
                    <div class="card-content">
                        <h4>덕가산<br><small>강원도 영월군</small></h4>
                    </div>
<%--                    <span class="heart-icon"><i class="far fa-heart"></i></span>--%>
                </div>

                <div class="card">
<<<<<<< HEAD
                    <img src="#" alt="취한대">
=======
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=169a3167-0d2a-4bf4-a680-cb8df73bc5c0" alt="백석봉(정선)">
>>>>>>> origin/feature_sebin
                    <div class="card-content">
                        <h4>백석봉(정선)<br><small>강원도 정선군</small></h4>
                    </div>
<%--                    <span class="heart-icon"><i class="far fa-heart"></i></span>--%>
                </div>

                <div class="card">
<<<<<<< HEAD
                    <img src="#" alt="산의한우마을">
=======
                    <img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDAyMThfMTkw%2FMDAxNzA4MjY1MTgzOTQ0.RqIVGcDhC1X9PLb6Z4pdU-qmIGnL2TG4mMAAyXqvFDog.w8ny-Go8I4pb4N5Tph-YrSs1PwS_Q8oZdkHSYsX8pa8g.JPEG.rtop221%2F%25B7%25CE%25B0%25ED20240218_215307.678.jpg&type=a340" alt="데미샘자연휴양림">
>>>>>>> origin/feature_sebin
                    <div class="card-content">
                        <h4>데미샘자연휴양림<br><small>전라북도 진안군</small></h4>
                    </div>
<%--                    <span class="heart-icon"><i class="far fa-heart"></i></span>--%>
                </div>

                <div class="card">
<<<<<<< HEAD
                    <img src="#" alt="대구 등산">
=======
                    <img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDA4MjFfMjk5%2FMDAxNzI0MTcyMTc3Mzg3.UYaBrb1zmdbf7D1dZGbEMmpxYRpwMkx_4ayoAo4MJ8sg.5GlKf4KjJigUkWl0nXDM7W8Xreb4LDJVNVDnrBVyHI4g.PNG%2F1724167398298.png&type=l340_165" alt="양평 쉬자파크">
>>>>>>> origin/feature_sebin
                    <div class="card-content">
                        <h4>양평 쉬자파크공원<br><small>경기도 양평군</small></h4>
                    </div>
<%--                    <span class="heart-icon"><i class="far fa-heart"></i></span>--%>
                </div>
            </div>

            <a href="#" class="more-button">오늘의 추천 코스<i class="fas fa-plus"></i></a>
        </div>
    </section>


    <section class="news-banner-section container">
        <div class="news-area">
            <h3>
                <a href="/Controller?type=notice" class="news-link">
                    오늘의 공지 사항 <i class="fas fa-plus plus-icon"></i>
                </a>
            </h3>
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
<<<<<<< HEAD
                    <img src="#" alt="경주 풍력발전소">
=======
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=7266caa0-cb58-48a0-a04b-0dd60ee0ac1c" alt="경주 풍력발전소" />
>>>>>>> origin/feature_sebin
                    <div class="card-content">
                        <h4>차 향 따라 쉬어가는 여름방학 🍧</h4>
                        <p>보성 가족여행 코스 추천</p>
                    </div>

                </div>
                <div class="healing-card">
<<<<<<< HEAD
                    <img src="#" alt="전남 미식 여행">
=======
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=89662693-e69e-4c7d-bd6d-b731a04df674" alt="단양 디지털 관광주민증" />
>>>>>>> origin/feature_sebin
                    <div class="card-content">
                        <h4>디지털 관광주민증으로 알뜰하게!</h4>
                        <p>단양에서 즐기는 짜릿한 여름</p>
                    </div>

                </div>
                <div class="healing-card">
<<<<<<< HEAD
                    <img src="#" alt="서울 걷기 명소">
=======
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=a483fc35-1ee1-4848-acce-ab9bf19b4819" alt="서울 사진미술관" />
>>>>>>> origin/feature_sebin
                    <div class="card-content">
                        <h4>따끈한 신상 공간,</h4>
                        <p>서울시립 사진미술관 📷</p>
                    </div>

                </div>
                <div class="healing-card">
<<<<<<< HEAD
                    <img src="#" alt="서울 트리하우스">
=======
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=f60d9fe7-8cf0-496a-be9e-9be868875f95" alt="템플스테이" />
>>>>>>> origin/feature_sebin
                    <div class="card-content">
                        <h4>템플스테이부터 천문대까지!</h4>
                        <p>영월의 여름을 즐기는 법</p>
                    </div>

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