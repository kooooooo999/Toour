<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<meta charset="UTF-8">
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

  .main-content h1 {
    font-size: 32px;
    margin-bottom: 30px;
    color: #000000;
  }

  #post {
    background-color: #f9f9f9;
    border-radius: 8px;
    padding: 25px;
    box-shadow: 0 0 12px rgba(0, 0, 0, 0.06);
  }

  #post table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 6px;
    overflow: hidden;
    box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
    table-layout: fixed;
    word-break: break-word;
  }

  #post th, #post td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    vertical-align: top;
  }

  #post th {
    background-color: #2c3e50;
    color: white;
    width: 120px;
    font-weight: 600;
  }

  #post td a {
    color: #2980b9;
    text-decoration: none;
  }

  #post td a:hover {
    text-decoration: underline;
  }

  #post input[type="button"] {
    background-color: #2980b9;
    border: none;
    color: white;
    padding: 8px 18px;
    margin-right: 10px;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  #post input[type="button"]:hover {
    background-color: #1f6391;
  }

  #del_dialog {
    font-size: 14px;
  }

  #del_dialog p {
    margin-bottom: 20px;
  }

  #del_dialog button {
    background-color: #e74c3c;
    border: none;
    color: white;
    padding: 6px 15px;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  #del_dialog button:hover {
    background-color: #c0392b;
  }

  #table thead th:nth-child(1) { width: 80px; }
  #table thead th:nth-child(2) { width: 100px; }
  #table thead th:nth-child(3) { width: 120px; }
  #table thead th:nth-child(4) { width: 150px; }
  #table thead th:nth-child(5) { width: 150px; }

</style>

<body>

<c:import url="/common/adminSidebar.jsp"/>

<div class="main-content">
  <h1>공지사항 관리 - 공지사항 보기</h1>


  <c:set var="vo" value="${requestScope.vo}"/>
  <c:set var="pvo" value="${requestScope.pvo}"/>

  <div id="post">
    <form method="post">
      <table>
        <tbody>
        <tr>
          <th>제목:</th>
          <td>${pvo.post_title}</td>
        </tr>

        <tr>
          <th>첨부파일:</th>
          <td><a href="#">
            <c:if test="${empty pvo.file_name_original}">
              첨부파일 없음
            </c:if>
            <c:if test="${not empty pvo.file_name_original}">
            ${pvo.file_name_original}
            </c:if>
          </a></td>
        </tr>

        <tr>
          <th>이름:</th>
          <td>관리자</td>
        </tr>

        <tr>
          <th>내용:</th>
          <td>${pvo.post_content}</td>
        </tr>

        <tr>
          <td colspan="2">
            <input type="button" value="수정" onclick="goEdit()"/>
            <input type="button" value="삭제" onclick="openDel()"/>
            <input type="button" value="목록" onclick="goList()"/>
          </td>
        </tr>
        </tbody>
      </table>
    </form>

    <form name="ff" method="post">
      <input type="hidden" name="type"/>
      <input type="hidden" name="post_idx" value="${vo.getPost_idx()}"/>
      <input type="hidden" name="cPage" value="${param.cPage}"/>
    </form>

    <div id="del_dialog" title="삭제">
      <form action="Controller" method="post">
        <p>정말로 삭제 하시겠습니까?</p>
        <input type="hidden" name="type" value="del"/>
        <input type="hidden" name="post" value="${vo.getPost_idx()}"/>
        <input type="hidden" name="cPage" value="${param.cPage}"/>
        <button type="button" onclick="goDel()">삭제</button>
      </form>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

<script>
  $(function () {
    $("#del_dialog").dialog({
      modal: true,
      autoOpen: false,
      resizable: false,
    });
  });

  function goList() {
    document.ff.action = "AdminController";
    document.ff.type.value = "adminnotice";
    document.ff.submit();
  }

  function openDel() {
    $("#del_dialog").dialog("open");
  }

  function goDel() {
    document.ff.action = "AdminController";
    document.ff.type.value = "adminnoticedel";
    document.ff.submit();
  }

  function goEdit() {
    document.ff.action = "AdminController";
    document.ff.type.value = "adminnoticeedit";
    document.ff.submit();
  }
</script>

</body>
</html>
