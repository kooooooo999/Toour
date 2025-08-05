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
  </style>
</head>
<body>

<div class="sidebar">
  <a href="AdminController">🏠 HOME</a>
  <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
  <a href="product_list.jsp?category=sp003">📝 게시물 관리</a>
  <a href="product_list.jsp?category=sp003">🍽 관광지/맛집 관리</a>
  <a href="product_list.jsp?category=sp003">🗺 관광코스 관리</a>
  <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
</div>

<div class="main-content">
  <h1>공지사항 관리</h1>

  <div id="post">
    <div class="search-area">
      <form method="post" action="Controller?type=postSearch" onsubmit="return validateForm()">
        <input type="hidden" name="category_idx" value="2">
        <select id="searchType" name="searchType">
          <option value="post_title">제목</option>
          <option value="post_content">내용</option>
          <option value="member_nickname">글쓴이</option>
        </select>
        <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue"/>
        <button type="submit">검색</button>
      </form>
    </div>

    <table summary="검색결과 목록">
      <caption>검색결과 목록</caption>
      <thead>
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>별점</th>
        <th>조회수</th>
        <th>작성일</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${not empty ar}">
        <c:set var="p" value="${requestScope.page}" />
        <c:forEach items="${ar}" var="vo" varStatus="vs">
          <c:set var="num" value="${p.totalCount -((p.nowPage-1)*p.numPerPage+vs.index)}"/>
          <tr>
            <td>${num}</td>
            <td>
              <a href="AdminController?type=adminnoticeview&post_idx=${vo.post_idx}&cPage=${nowPage}">
                  ${vo.post_title}
                <c:if test="${vo.c_list != null and fn:length(vo.c_list) > 0}">
                  (<c:out value="${fn:length(vo.c_list)}"/>)
                </c:if>
              </a>
            </td>
            <td>${vo.member_nickname}</td>
            <td>${vo.post_star}</td>
            <td>${vo.post_views}</td>
            <td>${vo.post_created_at.substring(0,10)}</td>
          </tr>
        </c:forEach>
      </c:if>
      </tbody>
    </table>
  </div>

  <div class="paging-area">
    <ol class="paging">
      <c:set var="p" value="${requestScope.page}" />
      <c:if test="${p.startPage < p.pagePerBlock}">
        <li class="disable">&lt;</li>
      </c:if>
      <c:if test="${p.startPage >= p.pagePerBlock}">
        <li><a href="AdminController?type=adminnotice&cPage=${p.startPage-p.pagePerBlock}">&lt;</a></li>
      </c:if>
      <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
        <c:choose>
          <c:when test="${p.nowPage == vs.index}">
            <li class="now">${vs.index}</li>
          </c:when>
          <c:otherwise>
            <li><a href="AdminController?type=adminnotice&cPage=${vs.index}">${vs.index}</a></li>
          </c:otherwise>
        </c:choose>
      </c:forEach>
      <c:if test="${p.endPage < p.totalPage}">
        <li><a href="AdminController?type=adminnotice&cPage=${p.endPage+1}">&gt;</a></li>
      </c:if>
      <c:if test="${p.endPage >= p.totalPage}">
        <li class="disable">&gt;</li>
      </c:if>
    </ol>
    <input type="button" value="글쓰기" onclick="javascript:location.href='AdminController?type=adminnoticewrite'">
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
