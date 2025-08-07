<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 1.
  Time: 오전 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="<c:url value="/css/style.css" />">

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
            <a href="myPage.jsp">마이 페이지</a>
            <a href="#">고객센터</a>
        </div>
    </div>
    <div class="container header-main flex-between">
        <a href="Controller" class="logo">👋🏻 toour</a>
        <div class="search-area">
            <input id="keyword" type="text" placeholder="어디로 떠나고 싶으신가요?" name="keyword"
            value="${param.keyword}"/>
            <i class="fas fa-search"></i>
        </div>

    </div>
    <nav class = "bar">

        <ul class = "menu">
            <li class="dropdown">
                <a href="Controller" class="act">홈</a>
            </li>
            <li class="dropdown">
                <a href="Controller?type=tripSuggestion" class="act">관광지</a>
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
                <a href="<c:url value="/Controller?type=list" />" class="act">게시판</a>
                <ul class="submenu">
                    <li><a href="<c:url value="/Controller?type=notice" />" class="act">공지사항</a></li>
                    <li><a href="#">건의/문의</a></li>
                    <li><a href="<c:url value="/Controller?type=list" />" class="act">여행후기</a></li>
                </ul>
            </li>

        </ul>
    </nav>
</header>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<script>
    function goSearch(str) {
        location.href = "Controller?type=headSearch";
    }

    // $("#keyword").on('keypress',function (e) {//keydown은 안됨 한박자 늦게 인식
    //     //사용자가 입력한 아이디가 u_id에 입력되므로 그곳에 있는 값(value)을 가져온다
    //     let str = $(this).val();//this는 #u_id
    //     //console.log(str);
    //     //str의 값에서 공백이 있는지 없는지 판단하고 유효성 검사 해야함-pass(정규표현식 쓰자)
    //     if (e.key === 'Enter') {
    //         e.preventDefault();
    //         if (str.trim().length > 0 && e.keyCode === 'Enter') {
    //             goSearch(str);
    //         }
    //     }
    // });

    $(function () {
        $('#keyword').on('keypress', function (e) { //keydown은 안됨 한박자 늦게 인식
            if (e.key === 'Enter') {
                e.preventDefault(); // 기본 submit 막기
                const keyword = $(this).val().trim();
                if (keyword.length === 0) {
                    return;
                }

                // 키워드 넘기기 (GET 방식으로 Controller에 전달)
                location.href = "Controller?type=searchKeyword&keyword=" + encodeURIComponent(keyword);
            }
        });
    });


</script>
