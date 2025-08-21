<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="toour.post.dao.NoticeDAO" %>
<%@ page import="toour.post.vo.PostVO" %>
<%@ page import="java.util.List" %>
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

<c:import url="/common/header.jsp"/>
<c:import url="/Controller?type=noticeMain"/>
<main>

    <section class="hero-travel-guide container">
        <div class="hero-content-left">
            <p class="tag_2">지역으로보는<strong> toour 관광지</strong></p>
            <p class="lineDetails_3">
            <p style="font-size: 20px">조회할 지역을 선택하세요</p>
            <div class="hero-pagination">
                <i class="fas fa-caret-left arrow"></i>
                <i class="fas fa-caret-right arrow"></i>
            </div>
        </div>
        <div class="hero-image-right">
            <%--            <img src="https://via.placeholder.com/600x400/d7e5f0/4e6e8e?text=Gyeongju+Travel+Image" alt="경북 영주 여행 이미지">--%>
        </div>
    </section>
    <jsp:include page="./sido.jsp"/>
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
                <p> 　</p>
            </div>

            <div class="recommend-cards">
                <div class="card">
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=b2526e1d-56a4-42df-9c98-f8255009c851"
                         alt="해운대">
                    <div class="card-content">
                        <h4>해운대 달맞이길<br><small>부산시 해운대구</small></h4>
                    </div>
                    <%--                    <span class="heart-icon"><i class="far fa-heart"></i></span>--%>
                </div>

                <div class="card">
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=3d29f393-801a-41dd-8472-a79a01642fce"
                         alt="백석봉(정선)">
                    <div class="card-content">
                        <h4>롯데월드<br><small>서울시 송파구</small></h4>
                    </div>
                    <%--                    <span class="heart-icon"><i class="far fa-heart"></i></span>--%>
                </div>

                <div class="card">
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=26eacf69-77ed-4ec7-a659-fe19f39ff7d1"
                         alt="데미샘자연휴양림">
                    <div class="card-content">
                        <h4>데미샘자연휴양림<br><small>전라북도 진안군</small></h4>
                    </div>
                    <%--                    <span class="heart-icon"><i class="far fa-heart"></i></span>--%>
                </div>

                <div class="card">
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=8132ce55-9fbf-4b85-8a8e-b324286393db"
                         alt="내동마을 연꽃단지">
                    <div class="card-content">
                        <h4>내동마을 연꽃단지<br><small>경기도 용인시</small></h4>
                    </div>
                    <%--                    <span class="heart-icon"><i class="far fa-heart"></i></span>--%>
                </div>
            </div>

            <a href="#" class="more-button">오늘의 추천 코스<i class="fas fa-plus"></i></a>
        </div>
    </section>

    <%
        // NoticeDAO를 사용하여 공지사항 목록을 가져옵니다.
        NoticeDAO noticeDAO = new NoticeDAO();
        int c = 4;
        List<toour.notice.vo.PostVO> noticeList = NoticeDAO.selectLatestNotice(c);

        // 가져온 목록을 request 속성에 저장합니다.
        request.setAttribute("noticeMainAr", noticeList);
    %>
    <section class="news-banner-section container">
        <div class="news-area">
            <h3>
                <a href="/Controller?type=notice" class="news-link">
                    오늘의 공지사항 <i class="fas fa-plus plus-icon"></i>
                </a>
            </h3>
            <ul class="news-list">
                <c:set value="${requestScope.noticeMainAr}" var="noticeMainAr"/>
                <c:forEach items="${noticeMainAr}" var="vo">
                    <li>
                        <span class="category">공지</span>
                        <span class="news-title">
                        <a href="Controller?type=noticeview&post_idx=${vo.post_idx}">
                                ${vo.post_title}
                        </a>
                    </span>
                        <span class="news-date">
                                ${vo.post_created_at.substring(0,10)}
                        </span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </section>



    <section class="healing-travel-section container section-padding">
        <h3 class="section-title">함께 떠나는 힐링테마 여행</h3>
        <div class="healing-carousel-wrapper">
            <div class="healing-card-wrapper">
                <div class="healing-card">
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=7266caa0-cb58-48a0-a04b-0dd60ee0ac1c"
                         alt="경주 풍력발전소"/>
                    <div class="card-content">
                        <h4>차 향 따라 쉬어가는 여름방학 🍧</h4>
                        <p>보성 가족여행 코스 추천</p>
                    </div>

                </div>
                <div class="healing-card">
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=89662693-e69e-4c7d-bd6d-b731a04df674"
                         alt="단양 디지털 관광주민증"/>
                    <div class="card-content">
                        <h4>디지털 관광주민증으로 알뜰하게!</h4>
                        <p>단양에서 즐기는 짜릿한 여름</p>
                    </div>

                </div>
                <div class="healing-card">
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=a483fc35-1ee1-4848-acce-ab9bf19b4819"
                         alt="서울 사진미술관"/>
                    <div class="card-content">
                        <h4>따끈한 신상 공간,</h4>
                        <p>서울시립 사진미술관 📷</p>
                    </div>

                </div>
                <div class="healing-card">
                    <img src="https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=f60d9fe7-8cf0-496a-be9e-9be868875f95"
                         alt="템플스테이"/>
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

<c:import url="/common/footer.jsp"/>

</body>

</html>