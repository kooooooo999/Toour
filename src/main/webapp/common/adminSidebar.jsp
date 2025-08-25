<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 20.
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>

  .sidebar {
    min-height: 150vh;
    width: 220px;
    background-color: #2c3e50;
    color: white;
    padding: 20px;
    display: flex;
    max-width: 25vw; /* 최대 넓이 설정 */
    min-width: 150px; /* 최소 넓이 설정 */
    flex-direction: column;
    flex-shrink: 0; /* 사이드바 너비 고정 */
    height: 200%; /* 이걸 꼭 추가! */

  }


  .sidebar a {
    text-decoration: none;
    color: white;
    padding: 12px 10px;
    border-bottom: 1px solid #34495e;
    transition: background-color 0.3s;
  }

  .sidebar a:hover {
    background-color: #34495e;
  }

  .content {
    flex-grow: 1;
    padding: 20px;
  }
</style>

<div class="sidebar">
  <!-- 메뉴 -->
  <a href="AdminController">🏠 관리자 홈</a>
  <a href="Controller">🛖 메인 홈</a>
  <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
  <a href="AdminController?type=adminpost">📝 게시물 관리</a>
  <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
  <a href="AdminController?type=adminInquiry&pageType=inquiry">📬문의사항 관리</a>
  <a href="AdminController?type=adminReport">🚨 신고사항 관리</a>
  <a href="Controller?type=login">🔓 로그아웃</a>
</div>