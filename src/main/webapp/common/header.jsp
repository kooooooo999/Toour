<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 1.
  Time: 오전 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<link rel="stylesheet" href="<c:url value="/css/style.css" />">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<header>
    <div class="container header-top">
        <div class="text-right">
            <c:if test="${sessionScope.member eq null}">
                <a href="Controller?type=moveLogin">로그인</a>
                <a href="Controller?type=moveSignup">회원가입</a>
            </c:if>
            <c:if test="${sessionScope.member ne null}">
                <c:if test="${sessionScope.member.member_type eq 0 }">
                    <a href="AdminController">관리자 홈</a>
                </c:if>
                <c:choose>
                    <c:when test="${sessionScope.member.login_type=='LOCAL'}">
                        <a href="Controller?type=login">로그아웃</a>
                    </c:when>

                    <c:when test="${sessionScope.member.login_type=='KAKAO'}">
                        <a href="javascript:void(0)" onclick="logoutKakao()">로그아웃</a>
                    </c:when>

                    <c:when test="${sessionScope.member.login_type=='NAVER'}">
                        <a href="Controller?type=naverlogout">로그아웃</a>
                    </c:when>
                </c:choose>
            </c:if>

            <a href="Controller?type=mypage">마이 페이지</a>
            <a href="Controller?type=QnA">고객센터</a>
        </div>
    </div>
    <div class="container header-main flex-between">
        <a href="Controller" class="logo"><span class="logo-emoji" aria-hidden="true">👋🏻</span> toour</a>
        <form id="search_form" accept-charset="UTF-8" method="post">
            <input id="keyword" type="text" placeholder="어디로 떠나고 싶으신가요?" name="keyword"/>
            <i class="fas fa-search"></i>
        </form>
    </div>

    </div>
    <nav class="bar">

        <ul class="menu">
            <li class="dropdown">
                <a href="Controller" class="act">홈</a>
            </li>
            <li class="dropdown">
                <a href="Controller?type=tripSuggestion&pageType=trip" class="act">관광지</a>
            </li>
            <li class="dropdown">
                <a href="javascript:goWay()" class="act">나만의 코스</a>
            </li>
            <li class="dropdown">
                <a href="Controller?type=tripSuggestion&pageType=course" class="act">추천코스</a>
            </li>
            <li class="dropdown">
                <a href="<c:url value="/Controller?type=list" />" class="act">게시판</a>
                <ul class="submenu">
                    <li><a href="<c:url value="/Controller?type=notice" />" class="act">공지사항</a></li>
                    <li><a href="<c:url value="/Controller?type=QnA"/>">건의/문의</a></li>
                    <li><a href="<c:url value="/Controller?type=list" />" class="act">여행후기</a></li>
                </ul>
            </li>

        </ul>
    </nav>
</header>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.5/kakao.min.js"
        integrity="sha384-dok87au0gKqJdxs7msEdBPNnKSRT+/mhTVzq+qOhcL464zXwvcrpjeWvyj1kCdq6"
        crossorigin="anonymous"></script>

<script>
    // Kakao SDK 안전 초기화 (중복/순서 문제 방지)
    (function ensureKakaoInit() {
        if (window.Kakao && !Kakao.isInitialized()) {
            Kakao.init('e8b842dc97356296e338660ae4063b8a'); // JS 키
            // console.log('Kakao initialized:', Kakao.isInitialized());
        }
    })();

    // 카카오 로그아웃 (어떤 페이지에서도 안전하게)
    function logoutKakao() {
        // SDK가 없거나 초기화가 안 되어 있어도 서버 로그아웃으로 폴백
        if (!(window.Kakao && Kakao.isInitialized())) {
            location.href = 'Controller?type=kakaologout';
            return;
        }

        var token = null;
        try {
            token = Kakao.Auth.getAccessToken && Kakao.Auth.getAccessToken();
        } catch (e) {
            // 일부 페이지에서 Kakao.Auth가 없을 수 있음 → 서버 로그아웃
        }

        if (!token) {
            location.href = 'Controller?type=kakaologout';
            return;
        }

        Kakao.Auth.logout(function () {
            location.href = 'Controller?type=kakaologout';
        });
    }

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

    function goWay() {

        <c:if test="${sessionScope.member ne null}">
            let form = document.createElement('form');
            form.method = 'POST';
            form.action = 'Controller?type=GoWay';
            document.body.appendChild(form);
            form.submit();
        </c:if>
        <c:if test="${sessionScope.member eq null}">
            alert("로그인 해주세요.");
        </c:if>
    }


</script>
