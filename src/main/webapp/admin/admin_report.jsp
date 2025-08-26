<%--
  Created by IntelliJ IDEA.
  User: kke33
  Date: 25. 8. 20.
  Time: 오후 5:22
  To change this template use File | Settings | File Templates.
--%>
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

    .paging-area {
      margin-top: 30px;
      text-align: center;
    }

    .paging {
      list-style: none;
      padding: 0;
      display: inline-block;
    }

    .paging li {
      display: inline-block;
      margin: 0 5px;
    }

    .paging li a,
    .paging li.now,
    .paging li.disable {
      display: inline-block;
      padding: 6px 12px;
      font-size: 13px;
      color: #3498db;
      text-decoration: none;
      border-radius: 4px;
      border: 1px solid transparent;
    }

    .paging li a:hover {
      background-color: #e7f0ff;
      border-color: #3498db;
    }

    .paging li.now {
      font-weight: 700;
      background-color: #3498db;
      color: white;
      border-color: #3498db;
    }

    .paging li.disable {
      color: #ccc;
      cursor: default;
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

<c:import url="/common/adminSidebar.jsp"/>


<div class="main-content">
  <h1>신고사항 관리</h1>
  <div id="post">
   <%-- <div class="search-area">
      <form method="post" action="AdminController?type=adminnoticesearch" onsubmit="return validateForm()">
        <input type="hidden" name="category_idx" value="1">
        <select id="searchType" name="searchType">
          <option value="post_title">제목</option>
          <option value="post_content">내용</option>
          <option value="member_nickname">글쓴이</option>
        </select>

        <input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue"/>
        <button type="submit">검색</button>

      </form>
      <input type="button" id="writebutton" value="글쓰기"
             onclick="javascript:location.href='AdminController?type=adminnoticewrite'">
    </div>--%>
     <div class="search-area">
       <form method="post" action="AdminController?type=adminreportsearch" onsubmit="return validateForm()">
         <select id="searchType" name="searchType">
           <option value="COMMENT" <c:if test="${requestScope.searchType eq 'COMMENT'}">selected</c:if>  >댓글</option>
           <option value="POST" <c:if test="${requestScope.searchType eq 'POST'}">selected</c:if> >게시글</option>
         </select>
         <i class="search"><button type="submit" class="search">검색</button></i>
       </form>
     </div>

     <c:set var="t" value="${requestScope.TotalCount}"/>

     <div class="totalCount">
       <p>총 <strong>${t}</strong>건</p>
     </div>




    <table>
      <%--      <caption>검색결과 목록</caption>--%>
      <thead>
      <tr>
        <th>번호</th>
        <th>신고인</th>
        <th>피신고인</th>
        <th>게시글/댓글</th>
        <th>신고내용</th>
        <th>신고작성일</th>
        <th>상태</th>
      </tr>
      </thead>
      <tbody>
      <c:if test="${not empty rvo}">
        <c:set var="p" value="${requestScope.page}"/>
        <c:forEach items="${rvo}" var="vo" varStatus="vs">
          <tr onclick="location.href='AdminController?type=adminpostview&post_idx=${vo.post_idx}&cPage=${nowPage}&comment_idx=${vo.comment_idx}'">
            <td>${vo.report_idx}</td>
            <td>${vo.reporter_nickname}</td>
            <td>${vo.reported_nickname}</td>
            <td><c:if test="${vo.target_type=='POST'}">게시글</c:if>
              <c:if test="${vo.target_type=='COMMENT'}">댓글</c:if>
            </td>
            <td>${vo.report_content}</td>
            <td>${vo.report_created_at.substring(0,10)}</td>
            <td>
              <c:if test="${vo.report_status == 0}">
                <p>처리전</p>
              </c:if>
              <c:if test="${vo.report_status == 1}">
                <p>처리완료</p>
              </c:if>
            </td>
          </tr>
        </c:forEach>
      </c:if>
      </tbody>
    </table>
  </div>

  <c:if test="${requestScope.searchType eq null}">
  <div class="paging-area">
    <ol class="paging">
      <c:set var="p" value="${requestScope.page}" />
      <c:if test="${p.startPage < p.pagePerBlock}">
        <li class="disable">&lt;</li>
      </c:if>
      <c:if test="${p.startPage >= p.pagePerBlock}">
        <li><a href="AdminController?type=adminReport&cPage=${p.startPage-p.pagePerBlock}">&lt;</a></li>
      </c:if>
      <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
        <c:if test="${p.nowPage == vs.index}">
          <li class="now">${vs.index}</li>
        </c:if>
        <c:if test="${p.nowPage != vs.index}">
          <li><a href="AdminController?type=adminReport&cPage=${vs.index}">${vs.index}</a></li>
        </c:if>
      </c:forEach>
      <c:if test="${p.endPage < p.totalPage}">
        <li><a href="AdminController?type=adminReport&cPage=${p.endPage+1}">&gt;</a></li>
      </c:if>
      <c:if test="${p.endPage >= p.totalPage}">
        <li class="disable">&gt;</li>
      </c:if>
    </ol>
  </div>
  </c:if>

  <c:if test="${requestScope.searchType ne null}">
    <div class="paging-area">
      <ol class="paging">
        <c:set var="p" value="${requestScope.page}" />
        <c:if test="${p.startPage < p.pagePerBlock}">
          <li class="disable">&lt;</li>
        </c:if>
        <c:if test="${p.startPage >= p.pagePerBlock}">
          <li><a href="AdminController?type=adminreportsearch&cPage=${p.startPage-p.pagePerBlock}&searchType=${requestScope.searchType}">&lt;</a></li>
        </c:if>
        <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
          <c:if test="${p.nowPage == vs.index}">
            <li class="now">${vs.index}</li>
          </c:if>
          <c:if test="${p.nowPage != vs.index}">
            <li><a href="AdminController?type=adminreportsearch&cPage=${vs.index}&searchType=${requestScope.searchType}">${vs.index}</a></li>
          </c:if>
        </c:forEach>
        <c:if test="${p.endPage < p.totalPage}">
          <li><a href="AdminController?type=adminreportsearch&cPage=${p.endPage+1}&searchType=${requestScope.searchType}">&gt;</a></li>
        </c:if>
        <c:if test="${p.endPage >= p.totalPage}">
          <li class="disable">&gt;</li>
        </c:if>
      </ol>
    </div>
  </c:if>

  <script>
    <%--
    검색 내용 유효성 검사
    --%>

    // function validateForm() {
    //   let searchType = document.getElementById('searchType').value;
    //   if (searchType.trim() === '') {
    //     alert('검색 내용을 입력하세요');
    //     return false;
    //   }
    //   return true;
    // }


  </script>
</div>
</body>
</html>
