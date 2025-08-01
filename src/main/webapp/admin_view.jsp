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
    }

    .sidebar {
      width: 220px;
      background-color: #2c3e50; /* 기존 색상 유지 */
      color: white;
      padding: 20px;
      display: flex;
      flex-direction: column;
    }

    .sidebar a {
      color: white;
      text-decoration: none;
      margin-bottom: 14px;
      padding: 10px 12px;
      border-radius: 6px;
      transition: background 0.3s;
    }

    .sidebar a:hover {
      background-color: #34495e;
    }

    .main-content {
      flex: 1;
      padding: 40px;
      background-color: #ffffff;
      overflow-y: auto;
    }

    h1 {
      /*color: #1e3a8a;*/
      margin-bottom: 30px;
    }

    .form-container {
      max-width: 600px;
      margin: 0 auto;
      background: #f9fbfe;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.05);
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-bottom: 6px;
      font-weight: 500;
      color: #333;
    }

    input[type="text"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #cbd5e1;
      border-radius: 6px;
      font-size: 14px;
      box-sizing: border-box;
    }

    .form-actions {
      text-align: center;
      margin-top: 30px;
    }

    input[type="submit"],
    input[type="button"] {
      padding: 10px 20px;
      margin: 0 10px;
      border: none;
      background-color: #1e40af;
      color: white;
      font-weight: 500;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    input[type="submit"]:hover,
    input[type="button"]:hover {
      background-color: #2563eb;
    }
  </style>
</head>
<body>

<div class="sidebar">
  <a href="admin_main.jsp">🏠 HOME</a>
  <a href="Controller?type=adminmemlist">📢 공지사항 관리</a>
  <a href="product_list.jsp?category=sp003">📝 게시물 관리</a>
  <a href="product_list.jsp?category=sp003">🍽 관광지/맛집 관리</a>
  <a href="product_list.jsp?category=sp003">🗺 관광코스 관리</a>
  <a href="admin_mem.jsp">👥 회원정보 관리</a>
</div>

<c:set var="vo" value="${requestScope.vo}" scope="page"/>
<div class="main-content">
  <h1>회원정보 관리</h1>
  <div class="form-container">
    <form action="Controller" method="post">
      <input type="hidden" name="type" value="memberUpdate"/>

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
        <input type="text" id="pw" name="member_password" value="${vo.member_password}">
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
        <input type="submit" value="수정" onclick="goRe()"/>
        <input type="button" value="탈퇴" onclick="goDel()"/>
        <input type="button" value="목록" onclick="location.href='Controller?type=adminmemlist'">
      </div>
    </form>

    <div id = "del_dialog" title="정말 삭제하시겠습니까?">
      <form action="Controller" method="post">
        <p>관리자 이름 확인</p>
        <input type="text" name="confirm"/>
        <input type="hidden" name="type" value="adminmemdel"/>
        <input type="hidden" name="member_idx" value="${vo.member_idx}"/>
        <input type="hidden" name="cPage" value="${param.cPage}"/>
        <button type="button" onclick="del(this.form)">삭제</button>
        <button type="button" id="member_cancel">취소</button>

      </form>

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
    $("#del_dialog").dialog(option);
  })

    function goDel(){
      $("#del_dialog").dialog("open");
    }

    $("#member_cancel").click(function (){
      $("#del_dialog").dialog("close");
    })


  function del(frm){
    frm.submit();
  }

</script>

</body>
</html>
