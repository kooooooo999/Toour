<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 1.
  Time: 오전 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./css/header.css">


<header>

    <div class="container header-top">
        <div class="text-right">
            <c:if test="${sessionScope.user eq null}">
                <a href="Controller?type=login">로그인</a>
                <a href="Controller?type=signup">회원가입</a>
            </c:if>
            <c:if test="${sessionScope.user ne null}">
                <a href="Controller?type=login">로그아웃</a>
            </c:if>
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
    <nav class = "bar">

        <ul class = "menu">
            <li class="dropdown">
                <a href="#" class = "act">홈</a>
            </li>
            <li class="dropdown">
                <a href="#" class="act">관광지</a>
                <ul class="submenu">
                    <li><a href="#">검색</a> </li>
                    <li><a href="Controller?type=tripSuggestion">테마</a> </li>
                    <li><a href="#">관광</a> </li>
                    <li><a href="#">관광</a> </li>
                    <li><a href="#">관광</a> </li>
                    <li><a href="#">관광</a> </li>
                </ul>
            </li>
            <li class="dropdown">
                <a href="#" class="act">맛집</a>
                <ul class="submenu">
                    <li><a href="#">검색</a> </li>
                    <li><a href="#">맛집</a> </li>
                    <li><a href="#">맛집</a> </li>
                    <li><a href="#">맛집</a> </li>
                    <li><a href="#">맛집</a> </li>
                    <li><a href="#">맛집</a> </li>
                </ul>
            </li>
            <li class="dropdown">
                <a href="#" class="act">추천코스</a>
                <ul class="submenu">
                    <li><a href="#">계획</a></li>
                    <li><a href="#">계획</a></li>
                    <li><a href="#">계획</a></li>
                    <li><a href="#">계획</a></li>
                    <li><a href="#">계획</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a href="#" class="act">게시판</a>
                <ul class="submenu">
                    <li><a href="#">공지사항</a></li>
                    <li><a href="#">건의/문의</a></li>
                    <li><a href="#">여행후기</a></li>
                </ul>
            </li>

        </ul>
    </nav>
</header>
