<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <title>관리자 페이지</title>
  <style>
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      display: flex;
      background-color: #f4f6f8;
    }

    .sidebar {
      width: 220px;
      background-color: #2c3e50;
      display: flex;
      flex-direction: column;
      padding: 20px;
      color: white;
      height: 100vh;
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

    .main-content {
      flex: 1;
      padding: 40px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      box-shadow: 0 0 8px rgba(0,0,0,0.1);
      border-radius: 6px;
      overflow: hidden;
    }

    thead {
      background-color: #fafafa;
      border-bottom: 2px solid #e1e4e8;
    }

    th {
      padding: 14px 20px;
      text-align: left;
      font-weight: 600;
      color: #2c3e50;
      font-size: 14px;
    }

    td {
      padding: 12px 20px;
      font-size: 13px;
      color: #4a4a4a;
    }

    td a {
      display: block;
      width: 100%;
      height: 100%;
      color: #34495e;
      text-decoration: none;
    }

    td a:hover {
      color: #1a73e8;
    }

    tbody tr:nth-child(even) {
      background-color: #f9fbfc;
    }

    tbody tr:hover {
      background-color: #e6f0ff;
    }

    td.no, th.no {
      width: 50px;
      text-align: center;
    }

    .pagination {
      margin: 20px auto;
      text-align: center;
      width: 100%;
    }

    .pagination a, .pagination span {
      display: inline-block;
      margin: 0 6px;
      padding: 6px 12px;
      font-size: 13px;
      color: #3498db;
      text-decoration: none;
      border-radius: 4px;
      border: 1px solid transparent;
    }

    .pagination a:hover {
      background-color: #e7f0ff;
      border-color: #3498db;
    }

    .pagination .current {
      font-weight: 700;
      background-color: #3498db;
      color: white;
      border-color: #3498db;
    }
  </style>
</head>
<body>

<div class="sidebar">
  <a href="admin_main.jsp">🏠 HOME</a>
  <a href="product_list.jsp?category=sp003">📢 공지사항 관리</a>
  <a href="product_list.jsp?category=sp003">📝 게시물 관리</a>
  <a href="product_list.jsp?category=sp003">🍽 관광지/맛집 관리</a>
  <a href="product_list.jsp?category=sp003">🗺 관광코스 관리</a>
  <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
</div>

<div class="main-content">
  <h1>회원정보 관리</h1>
  <table>
    <thead>
    <tr>
      <th class="no">번호</th>
      <th>이름</th>
      <th>아이디</th>
      <th>별명</th>
      <th>경고횟수</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="vo" items="${requestScope.ar}" varStatus="vs">
      <c:set var="p" value="${requestScope.page}" scope="page"/>
      <c:set var="num" value="${p.totalCount - ((p.nowPage - 1) * p.numPerPage + vs.index)}" />
      <tr>
        <td class="no">
          <a href="AdminController?type=adminmemview&member_idx=${vo.member_idx}&cPage=${p.nowPage}">
            <tr>
            <td>${num}</td>
          </a>
        </td>
        <td>
          <a href="AdminController?type=adminmemview&member_idx=${vo.member_idx}&cPage=${p.nowPage}">
              ${vo.member_name}
          </a>
        </td>
        <td>
          <a href="AdminController?type=adminmemview&member_idx=${vo.member_idx}&cPage=${p.nowPage}">
              ${vo.member_id}
          </a>
        </td>
        <td>
          <a href="AdminController?type=adminmemview&member_idx=${vo.member_idx}&cPage=${p.nowPage}">
              ${vo.member_nickname}
          </a>
        </td>
        <td>
          <a href="AdminController?type=adminmemview&member_idx=${vo.member_idx}&cPage=${p.nowPage}">
              ${vo.member_warning}
          </a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <div class="pagination">
    <c:if test="${p.startPage > 1}">
      <a href="Controller?type=list&cPage=${p.startPage - 1}">&lt;</a>
    </c:if>
    <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
      <c:choose>
        <c:when test="${p.nowPage == vs.index}">
          <span class="current">${vs.index}</span>
        </c:when>
        <c:otherwise>
          <a href="Controller?type=list&cPage=${vs.index}">${vs.index}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    <c:if test="${p.endPage < p.totalPage}">
      <a href="Controller?type=list&cPage=${p.endPage + 1}">&gt;</a>
    </c:if>
  </div>

</div> <!-- /main-content -->

</body>
</html>
