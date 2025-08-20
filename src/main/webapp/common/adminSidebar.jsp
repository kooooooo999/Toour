<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 20.
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
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
</style>

<div class="sidebar">
  <!-- 메뉴 -->
  <a href="AdminController">🏠 HOME</a>
  <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
  <a href="AdminController?type=adminpost">📝 게시물 관리</a>
  <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
  <a href="AdminController?type=adminInquiry&pageType=inquiry">📬문의사항 관리</a>
  <a href="AdminController?type=adminReport">🚨 신고사항 관리</a>
</div>