<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>


<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대한민국 구석구석 - 한국관광공사</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        table{
            width: 600px;
            border-collapse: collapse;
        }
        table th, table td{
            border: 1px solid black;
            padding: 5px;
        }
        table caption {
            text-indent: -9999px;
            height: 0;
        }
        /* CSS Reset & Global Styles */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Malgun Gothic', '맑은 고딕', sans-serif; line-height: 1.6; color: #333; background-color: #f8f9fa; font-size: 15px;}
        a { text-decoration: none; color: inherit; }
        ul { list-style: none; }
        img { max-width: 100%; height: auto; display: block; }
        .container { width: 90%; max-width: 1280px; margin: 0 auto; }
        .section-padding { padding: 40px 0; }
        .flex-between { display: flex; justify-content: space-between; align-items: center; }
        .text-center { text-align: center; }
        .text-right { text-align: right; }
        .section-title { font-size: 28px; font-weight: bold; color: #333; margin-bottom: 30px; }

        /* Header */
        header { background-color: #fff; border-bottom: 1px solid #eee; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .header-top { font-size: 13px; color: #666; padding: 5px 0; border-bottom: 1px solid #f0f0f0; }
        .header-top a { margin-left: 15px; }
        .header-main { padding: 15px 0; }
        .header-main .logo { font-size: 32px; font-weight: 900; color: #0056b3; }
        .header-main .search-area { position: relative; width: 350px; }
        .header-main .search-area input { width: 100%; padding: 10px 45px 10px 18px; border: 1px solid #ddd; border-radius: 25px; font-size: 15px; outline: none; }
        .header-main .search-area .fa-search { position: absolute; right: 18px; top: 50%; transform: translateY(-50%); color: #888; font-size: 18px; cursor: pointer; }
        .header-main .util-menu a { margin-left: 25px; font-size: 16px; color: #555; }
        .header-main .util-menu i { font-size: 20px; vertical-align: middle; margin-right: 5px;}

        /* Main Navigation */
        nav.main-nav { background-color: #0056b3; padding: 15px 0; }
        nav.main-nav ul { display: flex; justify-content: space-around; }
        nav.main-nav a { color: #fff; font-weight: bold; font-size: 16px; padding: 5px 0; transition: color 0.3s ease; }
        nav.main-nav a:hover { text-decoration: underline; }

        /* Hero Section (여행콕콕 메인) */
        .hero-travel-guide { background-color: #f7f7f7; padding: 50px 0; display: flex; align-items: center; }
        .hero-travel-guide .hero-content-left { width: 45%; padding-right: 40px; }
        .hero-travel-guide .hero-content-left small { display: block; font-size: 18px; color: #888; margin-bottom: 10px; }
        .hero-travel-guide .hero-content-left h2 { font-size: 40px; font-weight: bold; margin-bottom: 20px; line-height: 1.3; }
        .hero-travel-guide .hero-content-left .detail-btn { display: inline-block; background-color: #007bff; color: white; padding: 12px 25px; border-radius: 5px; font-size: 16px; margin-top: 20px; transition: background-color 0.3s ease; }
        .hero-travel-guide .hero-content-left .detail-btn:hover { background-color: #0056b3; }
        .hero-travel-guide .hero-image-right { width: 55%; }
        .hero-travel-guide .hero-image-right img { border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .hero-travel-guide .hero-pagination { margin-top: 30px; display: flex; align-items: center; justify-content: flex-end; width: 100%; }
        .hero-travel-guide .hero-pagination span { font-size: 16px; color: #666; margin: 0 15px; }
        .hero-travel-guide .hero-pagination .arrow { font-size: 24px; color: #999; cursor: pointer; margin: 0 5px; }

        /* 여행콕콕 Section */
        .travel-cockcock { padding: 40px 0; background-color: #e6f0ff; border-radius: 10px; margin-bottom: 40px; }
        .travel-cockcock .section-header { text-align: center; margin-bottom: 30px; }
        .travel-cockcock .section-header h3 { font-size: 28px; color: #0056b3; margin-bottom: 10px; }
        .travel-cockcock .section-header p { font-size: 16px; color: #555; }
        .travel-cockcock .tabs { display: flex; justify-content: center; margin-bottom: 30px; }
        .travel-cockcock .tabs button { background-color: #b3d9ff; color: #0056b3; border: none; padding: 12px 30px; margin: 0 5px; border-radius: 25px; font-size: 17px; font-weight: bold; cursor: pointer; transition: background-color 0.3s ease, color 0.3s ease; }
        .travel-cockcock .tabs button.active { background-color: #0056b3; color: white; }
        .travel-cockcock .tabs button:hover:not(.active) { background-color: #99ccff; }
        .travel-cockcock .recommend-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; }
        .travel-cockcock .card { background-color: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.08); transition: transform 0.3s ease; position: relative; }
        .travel-cockcock .card:hover { transform: translateY(-5px); }
        .travel-cockcock .card img { width: 100%; height: 200px; object-fit: cover; }
        .travel-cockcock .card-content { padding: 15px; }
        .travel-cockcock .card-content h4 { font-size: 18px; margin-bottom: 5px; color: #333; }
        .travel-cockcock .card-content p { font-size: 14px; color: #777; margin-bottom: 10px; }
        .travel-cockcock .card .heart-icon { position: absolute; top: 10px; right: 10px; background-color: rgba(255,255,255,0.8); border-radius: 50%; width: 30px; height: 30px; display: flex; justify-content: center; align-items: center; font-size: 16px; color: #e74c3c; cursor: pointer; }
        .travel-cockcock .more-button { display: block; width: 200px; padding: 12px 0; background-color: #fff; border: 1px solid #ddd; border-radius: 25px; margin: 40px auto 0; text-align: center; font-size: 16px; font-weight: bold; color: #555; transition: background-color 0.3s ease; }
        .travel-cockcock .more-button:hover { background-color: #f0f0f0; }

        /* Event Section */
        .event-section { padding: 40px 0; }
        .event-section h3 { margin-bottom: 30px; }
        .event-carousel { display: flex; overflow: hidden; position: relative; } /* JavaScript for actual carousel */
        .event-card-wrapper { display: flex; gap: 20px; } /* For displaying multiple cards */
        .event-card { flex: 0 0 calc(25% - 15px); max-width: calc(25% - 15px); background-color: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .event-card img { width: 100%; height: 200px; object-fit: cover; }
        .event-card-content { padding: 15px; }
        .event-card-content p { font-size: 15px; color: #555; margin-bottom: 5px; }
        .event-card-content .date { font-size: 13px; color: #999; }
        .event-navigation { position: absolute; top: 50%; right: 0; transform: translateY(-50%); background-color: rgba(255,255,255,0.8); border-radius: 50%; width: 40px; height: 40px; display: flex; justify-content: center; align-items: center; font-size: 20px; cursor: pointer; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .event-pagination-dots { text-align: center; margin-top: 20px; font-size: 14px; color: #666; }

        /* Today's News & Event Banner */
        .news-banner-section { display: flex; gap: 30px; margin-bottom: 40px; }
        .news-area { flex: 1; background-color: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); padding: 30px; }
        .news-area h3 { font-size: 24px; color: #333; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .news-area h3 .plus-icon { font-size: 20px; color: #888; cursor: pointer; }
        .news-area .news-list li { padding: 12px 0; border-bottom: 1px dashed #eee; display: flex; align-items: center; }
        .news-area .news-list li:last-child { border-bottom: none; }
        .news-area .news-list .category { display: inline-block; background-color: #e0f0ff; color: #007bff; font-size: 12px; padding: 3px 8px; border-radius: 3px; margin-right: 10px; }
        .news-area .news-list .news-title { flex-grow: 1; }
        .news-area .news-list .news-date { font-size: 13px; color: #999; margin-left: 10px; }

        .banner-area { flex: 0 0 35%; /* Adjust width as needed */ background-color: #e9f5ff; border-radius: 8px; padding: 30px; display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center; background-image: url('https://via.placeholder.com/400x200/cbe1ff/007bff?text=Event+Banner+Image'); background-size: cover; background-position: center; color: #333; }
        .banner-area .event-badge { background-color: #ffeb3b; color: #333; font-weight: bold; padding: 5px 10px; border-radius: 5px; font-size: 13px; margin-bottom: 10px; }
        .banner-area p { font-size: 20px; font-weight: bold; line-height: 1.4; }
        .banner-area small { font-size: 14px; color: #666; margin-top: 5px; }

        /* Healing Theme Travel Section */
        .healing-travel-section { padding: 40px 0; }
        .healing-travel-section h3 { margin-bottom: 30px; }
        .healing-carousel-wrapper { position: relative; overflow: hidden; }
        .healing-card-wrapper { display: flex; gap: 20px; }
        .healing-card { flex: 0 0 calc(25% - 15px); max-width: calc(25% - 15px); background-color: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .healing-card img { width: 100%; height: 200px; object-fit: cover; }
        .healing-card-content { padding: 15px; }
        .healing-card-content h4 { font-size: 16px; margin-bottom: 5px; color: #333; }
        .healing-card-content p { font-size: 13px; color: #777; margin-bottom: 10px; }
        .healing-card .heart-icon { position: absolute; top: 10px; right: 10px; background-color: rgba(255,255,255,0.8); border-radius: 50%; width: 30px; height: 30px; display: flex; justify-content: center; align-items: center; font-size: 16px; color: #e74c3c; cursor: pointer; }
        .healing-navigation { position: absolute; top: 50%; right: 0; transform: translateY(-50%); background-color: rgba(255,255,255,0.8); border-radius: 50%; width: 40px; height: 40px; display: flex; justify-content: center; align-items: center; font-size: 20px; cursor: pointer; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .healing-pagination-dots { text-align: center; margin-top: 20px; font-size: 14px; color: #666; }


        /* Footer */
        footer { background-color: #343a40; color: #ddd; padding: 40px 0; font-size: 14px; }
        .footer-news-ticker { background-color: #4a545e; color: #fff; padding: 10px 0; font-size: 13px; margin-bottom: 20px; }
        .footer-news-ticker .ticker-content { display: flex; align-items: center; width: 100%; /* For actual ticker logic */ }
        .footer-news-ticker .ticker-content span { margin-left: 20px; }
        .footer-news-ticker .ticker-controls { display: flex; margin-left: auto; padding-right: 20px; }
        .footer-news-ticker .ticker-controls i { margin-left: 10px; cursor: pointer; }

        .footer-sns-links { display: flex; justify-content: center; gap: 30px; margin-bottom: 30px; }
        .footer-sns-links a { display: flex; flex-direction: column; align-items: center; color: #ddd; font-size: 13px; }
        .footer-sns-links .sns-icon { background-color: #666; width: 50px; height: 50px; border-radius: 50%; display: flex; justify-content: center; align-items: center; font-size: 24px; margin-bottom: 8px; transition: background-color 0.3s ease; }
        .footer-sns-links a:hover .sns-icon { background-color: #007bff; }

        .footer-banners { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 15px; margin-bottom: 30px; }
        .footer-banners .banner-item { background-color: #f0f0f0; border-radius: 5px; overflow: hidden; text-align: center; }
        .footer-banners .banner-item img { width: 100%; height: 80px; object-fit: cover; }
        .footer-banners .banner-item p { font-size: 13px; padding: 8px 5px; color: #555; } /* If text overlay */

        footer .footer-nav ul { display: flex; justify-content: center; margin-bottom: 20px; }
        footer .footer-nav li { margin: 0 15px; }
        footer .footer-nav a { color: #ccc; transition: color 0.3s ease; }
        footer .footer-nav a:hover { color: #fff; }
        footer address { text-align: center; margin-bottom: 10px; }
        footer p.contact-info { text-align: center; margin-top: 10px; }
        footer .copyright { text-align: center; margin-top: 20px; font-size: 13px; color: #aaa; }
    </style>
    <title>JSP - Hello World</title>
    <style>
        #table{
            border-collapse: collapse;
        }
        #table caption{
            text-indent: -9999px;
            height: 0;
        }
        #table td{
            border: 1px solid #000;
        }
    </style>
</head>
<body>
<header>
    <h1>행사목록</h1>
</header>
<article>
    <table>
        <caption>연습</caption>
        <thead>
        <tr>
            <th>번호</th>
            <th>이미지</th>
            <th>제목</th>
            <th>전화번호</th>
            <th>주소</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="vo" items="${requestScope.ar}" varStatus="vs">
            <tr>
                <td>${vs.index+1}</td>
                <td><img src = "${vo.firstimage2}"/></td>
                <td>${vo.title}</td>
                <td>${vo.tel}</td>
                <td>${vo.addr1} &nbsp; ${vo.addr2}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</article>
 <button onclick="location.href='Controller?type=signup'">회원가입</button>
 <button onclick="location.href='Controller?type=login'">로그인</button>



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
        <a href="#" class="logo">대한민국 구석구석</a>
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
            <li><a href="#">여행정보</a></li>
            <li><a href="#">게시판</a></li>
        </ul>
    </div>
</nav>

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
    <jsp:include page="sido.jsp"/>
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
                    <img src="https://via.placeholder.com/300x200?text=Nodo+Island" alt="노도(김만중)">
                    <div class="card-content">
                        <h4>노도(김만중)<br><small>경상남도 남해군</small></h4>
                        <p>섬 전체가 하나의 거대한 문학 공원</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="card">
                    <img src="https://via.placeholder.com/300x200?text=Chwihancheonjeong" alt="취한대">
                    <div class="card-content">
                        <h4>취한대<br><small>경상남도 하동군</small></h4>
                        <p>지리산 산자락에 위치한 고즈넉한 정자</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="card">
                    <img src="https://via.placeholder.com/300x200?text=Sanui+Hanok+Village" alt="산의한우마을">
                    <div class="card-content">
                        <h4>산의한우마을<br><small>전라북도 진안군</small></h4>
                        <p>싱싱한 한우를 맛볼 수 있는 한우거리</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="card">
                    <img src="https://via.placeholder.com/300x200?text=Daegu+Hiking" alt="대구 등산">
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
                    <img src="https://via.placeholder.com/300x200?text=Gyeongju+Windmill" alt="경주 풍력발전소">
                    <div class="card-content">
                        <h4>일출 명소부터 짜릿한 체험까지!</h4>
                        <p>경주에서 보내는 특별한 하루</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="healing-card">
                    <img src="https://via.placeholder.com/300x200?text=Jeonnam+Sea" alt="전남 미식 여행">
                    <div class="card-content">
                        <h4>입안 가득 바다의 맛 🎣</h4>
                        <p>전남 미식 여행 코스 추천</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="healing-card">
                    <img src="https://via.placeholder.com/300x200?text=Seoul+Healing+Trail" alt="서울 걷기 명소">
                    <div class="card-content">
                        <h4>낭만 치사랑 한도 초과💖</h4>
                        <p>서울 경기 능소화 명소 4</p>
                    </div>
                    <span class="heart-icon"><i class="far fa-heart"></i></span>
                </div>
                <div class="healing-card">
                    <img src="https://via.placeholder.com/300x200?text=Seoul+Treehouse" alt="서울 트리하우스">
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
</body>
</html>