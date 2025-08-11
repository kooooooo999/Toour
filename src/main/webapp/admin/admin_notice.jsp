<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
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

    .search-area {
      background: #fff;
      padding: 20px;
      margin-bottom: 30px;
      border: 1px solid #e1e4e8;
      border-radius: 6px;
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .search-area form {
      display: flex;
      gap: 10px;
      align-items: center;
    }

    .search-area select,
    .search-area input[type="text"],
    .search-area button,
    #writebutton {
      padding: 8px 12px;
      font-size: 14px;
      border-radius: 4px;
      background: white;
      color: #2c3e50;
      border: 1px solid #ccc;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .search-area button,
    #writebutton {
      background-color: #3498db;
      color: white;
      border: none;
    }

    .search-area button:hover,
    #writebutton:hover {
      background-color: #2980b9;
    }
  </style>
</head>
<body>

<div class="sidebar">
  <a href="AdminController">🏠 HOME</a>
  <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
  <a href="AdminController?type=adminpost">📝 게시물 관리</a>
  <a href="product_list.jsp?category=sp003">🍽 관광지/맛집 관리</a>
  <a href="product_list.jsp?category=sp003">🗺 관광코스 관리</a>
  <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
</div>

<div class="main-content">
  <h1>공지사항 관리</h1>

  <div id="post">
    <div class="search-area">
      <form method="post" action="AdminController?type=adminnoticesearch" onsubmit="return validateForm()">
        <input type="hidden" name="category_idx" value="2">
        <select id="searchType" name="searchType">
          <option value="post_title">제목</option>
          <option value="post_content">내용</option>
          <option value="member_nickname">글쓴이</option>
        </select>

        <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue"/>
        <button type="submit">검색</button>

      </form>
      <input type="button" id="writebutton" value="글쓰기" onclick="javascript:location.href='AdminController?type=adminnoticewrite'">
    </div>

    <table>
<%--      <caption>검색결과 목록</caption>--%>
      <thead>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>조회수</th>
        <th>작성일</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${not empty ar}">
        <c:set var="p" value="${requestScope.page}" />
        <c:forEach items="${ar}" var="vo" varStatus="vs">
          <tr>
            <td>${vo.post_idx}</td>
            <td>
              <a href="AdminController?type=adminnoticeview&post_idx=${vo.post_idx}&cPage=${nowPage}">
                  ${vo.post_title}
                <c:if test="${vo.c_list != null and fn:length(vo.c_list) > 0}">
                  (<c:out value="${fn:length(vo.c_list)}"/>)
                </c:if>
              </a>
            </td>
            <td>${vo.member_nickname}</td>
            <td>${vo.post_views}</td>
            <td>${vo.post_created_at.substring(0,10)}</td>
          </tr>
        </c:forEach>
      </c:if>
      </tbody>
    </table>
  </div>

  <div class="pagination">
    <c:if test="${p.startPage > 1}">
      <a href="AdminController?type=adminnotice&cPage=${p.startPage - 1}">&lt;</a>
    </c:if>
    <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
      <c:choose>
        <c:when test="${p.nowPage == vs.index}">
          <span class="current">${vs.index}</span>
        </c:when>
        <c:otherwise>
          <a href="AdminController?type=adminnotice&cPage=${vs.index}">${vs.index}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    <c:if test="${p.endPage < p.totalPage}">
      <a href="AdminController?type=adminnotice&cPage=${p.endPage + 1}">&gt;</a>
    </c:if>
  </div>


  <script>
    <%--
    검색 내용 유효성 검사
    --%>
    function validateForm() {
      let searchValue = document.getElementById('searchValue').value;
      if(searchValue.trim() === '' ){
        alert('검색 내용을 입력하세요');
        return false;
      }
      return true;
    }
  </script>
</div>
</body>
</html>
