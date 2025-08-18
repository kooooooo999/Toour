<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
  <title>회원정보 관리</title>
  <style>
      body {
          margin: 0;
          font-family: 'Noto Sans KR', sans-serif;
          background-color: #f0f4f8;
          display: flex;
          height: 100vh;
          font-size: 14px; /* 기본 글자 크기 약간 줄임 */
      }

      .sidebar {
          width: 200px; /* 너비 줄임 */
          background-color: #2c3e50;
          color: white;
          padding: 15px 20px;
          display: flex;
          flex-direction: column;
          font-size: 14px; /* 사이드바 글자 크기 */
      }

      .sidebar a {
          color: white;
          text-decoration: none;
          margin-bottom: 12px;
          padding: 8px 10px;
          border-radius: 5px;
          transition: background 0.3s;
          font-size: 14px;
      }

      .sidebar a:hover {
          background-color: #34495e;
      }

      .main-content {
          flex: 1;
          padding: 30px 40px;
          background-color: #fff;
          overflow-y: auto;
          display: flex;
          flex-direction: column;
          font-size: 14px;
      }

      h1 {
          margin-bottom: 20px;
          font-weight: 600;
          color: #2563eb; /* 진한 파랑 대신 #2563eb */
          font-size: 22px;
      }

      .search-area {
          margin-bottom: 15px;
      }

      form.search-form {
          display: flex;
          gap: 8px;
          align-items: center;
      }

      select, input[type="text"] {
          padding: 6px 10px;
          font-size: 13px;
          border: 1px solid #cbd5e1;
          border-radius: 5px;
          outline: none;
          font-family: 'Noto Sans KR', sans-serif;
          box-sizing: border-box;
      }

      button {
          padding: 7px 16px;
          background-color: #2563eb; /* 요청하신 색 */
          color: white;
          border: none;
          border-radius: 5px;
          font-weight: 500;
          cursor: pointer;
          font-size: 14px;
          transition: background-color 0.3s;
      }

      button:hover {
          background-color: #1d4ed8;
      }

      table {
          width: 100%;
          border-collapse: collapse;
          border-radius: 5px;
          overflow: hidden;
          box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
          margin-bottom: 25px;
          font-size: 14px;
      }

      thead {
          background-color: #2563eb; /* 요청 색으로 변경 */
          color: white;
          font-weight: 600;
      }

      th, td {
          padding: 12px 10px;
          text-align: left;
          border-bottom: 1px solid #e2e8f0;
          font-size: 13px;
      }

      tbody tr:hover {
          background-color: #f0f4f8;
          cursor: pointer;
      }

      tbody tr td a {
          color: #2563eb; /* 링크 색상도 동일 */
          text-decoration: none;
          font-size: 13px;
      }

      tbody tr td a:hover {
          text-decoration: underline;
      }

      .paging-area {
          display: flex;
          justify-content: space-between;
          align-items: center;
          font-size: 13px;
      }

      ol.paging {
          list-style: none;
          display: flex;
          gap: 6px;
          padding: 0;
          margin: 0;
      }

      ol.paging li {
          padding: 5px 10px;
          border-radius: 5px;
          border: 1px solid #cbd5e1;
          font-size: 13px;
          cursor: pointer;
          user-select: none;
      }

      ol.paging li.now {
          background-color: #2563eb;
          color: white;
          border-color: #2563eb;
          cursor: default;
      }

      ol.paging li.disable {
          color: #a0aec0;
          cursor: default;
          border-color: #e2e8f0;
      }

      ol.paging li a {
          text-decoration: none;
          color: inherit;
          display: block;
          width: 100%;
          height: 100%;
      }

      input[type="button"].write-btn {
          background-color: #2563eb;
          padding: 8px 18px;
          border: none;
          color: white;
          font-weight: 600;
          border-radius: 5px;
          cursor: pointer;
          transition: background-color 0.3s;
          font-size: 14px;
      }

      input[type="button"].write-btn:hover {
          background-color: #1d4ed8;
      }


  </style>
</head>
<body>

<div class="sidebar">
    <a href="AdminController">🏠 HOME</a>
    <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
    <a href="AdminController?type=adminpost">📝 게시물 관리</a>
    <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
</div>


<c:set var="vo" value="${requestScope.vo}" scope="page"/>
<div class="main-content">

  <h1>회원정보 관리</h1>
  <div class="form-container">
      <form id = "editform" name="editform" action="AdminController" method="post">
        <input type="hidden" name="type" value="adminmemedit">
        <input type="hidden" name="member_idx" value="${vo.member_idx}">
        <input type="hidden" name="cPage" value="${param.cPage}">

      <div class="form-group">
        <label for="name">이름</label>
        <input type="text" id="name" name="member_name" value="${vo.member_name}">
      </div>

      <div class="form-group">
        <label for="id">아이디</label>
        <input type="text" id="id" name="member_id" value="${vo.member_id}" readonly>
      </div>

      <div class="form-group">
        <label for="pw">비밀번호</label>
        <input type="password" id="pw" name="member_password" value="${vo.member_password}" readonly>
      </div>

      <div class="form-group">
        <label for="nickname">별명</label>
        <input type="text" id="nickname" name="member_nickname" value="${vo.member_nickname}">
      </div>

      <div class="form-group">
        <label for="email">이메일</label>
        <input type="text" id="email" name="member_email" value="${vo.member_email}">
      </div>

      <div class="form-group">
        <label for="email">경고횟수</label>
        <input type="text" id="warning" name="member_warning" value="${vo.member_warning}">
      </div>

      <div class="form-actions">
        <input type="button" value="수정" onclick="openEdit()"/>
        <input type="button" value="목록" onclick="location.href='AdminController?type=adminmemlist'">
      </div>
    </form>

    <form name="ff" method="post">
      <input type="hidden" name="type"/>
      <input type="hidden" name="member_idx" value="${vo.member_idx}"/>
      <input type="hidden" name="cPage" value="${param.cPage}"/>
    </form>


    <!-- 수정 다이얼로그 -->
    <div id = "edit_dialog" title = "수정하시겠습니까?">
        <div class="button-group">
        <button type="button" onclick="goEdit(this.form)">수정</button>
        <button type="button" id = "member_edit_cancel">취소</button>
        </div>
    </div>
  </div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>

<script>
  $(function (){
    let option = {
      modal: true,
      autoOpen: false,
      resizable: false,
    };
    $("#edit_dialog").dialog(option);
  })

    function openEdit(){
      $("#edit_dialog").dialog("open");
    }

    $("#member_edit_cancel").click(function (){
      $("#edit_dialog").dialog("close");
    })


  function goEdit(){
    if($("#name").val().trim().length<1){
      alert("제목을 입력하세요");
      $("#name").val("")
      $("#name").focus()
      return
    }
    else {
      document.editform.action = "AdminController";
      document.editform.type.value = "adminmemedit";
      document.editform.submit();
    }
  }

</script>

</body>
</html>
