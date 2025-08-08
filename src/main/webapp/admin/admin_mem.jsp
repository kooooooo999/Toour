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
    #delbutton {
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
    #delbutton {
      background-color: #3498db;
      color: white;
      border: none;
    }

    .search-area button:hover,
    #delbutton:hover {
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

<div class="main-content" id="post">
  <h1>회원정보 관리</h1>


  <div class="search-area">
    <form method="post" action="AdminController?type=adminmemsearch" onsubmit="return validateForm()">
      <select id="searchType" name="searchType">
        <option value="member_name">이름</option>
        <option value="member_id">아이디</option>
        <option value="member_nickname">별명</option>
        <option value="member_warning">경고횟수</option>
      </select>
      <label for="searchValue"></label><input type="text" id="searchValue" placeholder="검색내용을 입력해주세요" name="searchValue"/>
      <i class="fas fa-search"><button type="submit" class="fas">검색</button></i>
    </form>

      <form id = "delform" method="post" action="AdminController?type=adminmemdel">
      <input id="delbutton" type="button" value="삭제" onclick="openDel()"/>

      <!-- 삭제 다이얼로그 -->
      <div id = "del_dialog" title = "삭제하시겠습니까?">
        <div class="button-group">
          <button type="button" onclick="goDel()">삭제</button>
          <button type="button" id = "member_del_cancel">취소</button>
        </div>
      </div>

<%--      <%--%>
<%--        String searchType = request.getParameter("searchType");--%>
<%--        String searchValue = request.getParameter("searchValue");--%>
<%--      %>--%>
<%--      <p>searchType: <%= searchType %></p>--%>
<%--      <p>searchValue: <%= searchValue %></p>--%>
  </div>

  <table id="table">
    <thead>
    <tr>
      <th><input type="checkbox"><span>전체선택</span></th>
      <th class="no">회원번호</th>
      <th>이름</th>
      <th>아이디</th>
      <th>별명</th>
      <th>경고횟수</th>
    </tr>
    </thead>



    <tbody>
    <c:set var="p" value="${requestScope.page}"/>
    <c:forEach var="vo" items="${requestScope.ar}" varStatus="vs">
      <c:if test="${vo.member_type eq 1}">
        <tr>
          <td>
            <label>
              <input type="checkbox" name="member_idx" value="${vo.member_idx}"/>
            </label>
          </td>
        <td class="no">
        <a href="AdminController?type=adminmemview&member_idx=${vo.member_idx}&cPage=${p.nowPage}">
            ${vo.member_idx} >_<
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
    </c:if>
    </c:forEach>
    </tbody>
  </table>



  <div class="pagination">
    <c:if test="${p.startPage > 1}">
      <a href="AdminController?type=adminmemlist&cPage=${p.startPage - 1}">&lt;</a>
    </c:if>

    <c:forEach begin="${p.startPage}" end="${p.endPage}" varStatus="vs">
      <c:choose>
        <c:when test="${p.nowPage == vs.index}">
          <span class="current">${vs.index}</span>
        </c:when>

        <c:otherwise>
          <a href="AdminController?type=adminmemlist&cPage=${vs.index}">${vs.index}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <c:if test="${p.endPage < p.totalPage}">
      <a href="AdminController?type=adminmemlist&cPage=${p.endPage + 1}">&gt;</a>
    </c:if>
  </div>

</div> <!-- /main-content -->
</body>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

<script>

  $(function (){
    let option = {
      modal: true,
      autoOpen: false,
      resizable: false,
    };
    $("#del_dialog").dialog(option);
  })

  function openDel() {
    $("#del_dialog").dialog("open");
  }

  $("#member_del_cancel").click(function (){
    $("#del_dialog").dialog("close");
  })

  function goDel() {
    document.getElementById("delform").submit();
  }

    function validateForm() {
      let searchValue = document.getElementById('searchValue').value;
      if (searchValue.trim() === '') {
        alert('검색내용을 입력하세요.');
        return false;
      }
      return true;
    }

  $(function (){
  // 전체 선택, 전체 해제
  $("#table thead input:checkbox").click(function (){
    //console.log("TT");
    // 클릭한 checkbox의 가장 가까운 태그(상위태그)를 알아낸다.
    //let p = $(this).parent(); //th
    let p = $(this).closest("th");// 현재 클릭한 체크박스의 가장 가까운 태그(th)

    // 앞서 구한 부모태그(th)가 해당 행(tr)에서 몇번째 요소인지
    // 인덱스를 알아내자
    let idx = $("#table thead tr th").index(p);
    // console.log(idx);

    // 구한 index값을 가지고 tbody에 있는 각 행에서
    // 해당 idx+1번째에 있는 td안의 체크박스들을 얻어낸다.
    let ar = $("#table tbody td:nth-child("+(idx+1)+") input:checkbox");
    ar.prop("checked", this.checked);
  });

    //전체선택을 클릭한 뒤, tbody에 있는 클릭 한 개가 해제되면 전체선택 체크박스도 해제
    $("#table tbody input:checkbox").click(function (){

      //tbody에서 체크박스의 개수와 tbody에서 체크된 체크박스의 개수 비교
      let AllChecked = $("#table tbody input:checkbox").length == $("#table tbody input:checkbox:checked").length;
      $("#table thead input:checkbox").prop("checked", AllChecked);


    });
  });

</script>

</html>
