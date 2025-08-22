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
    flex-direction: row; /* 사이드바 때문 */
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


  /* 메인 컨텐츠 영역 */
  .main_content {
    flex: 1;
    padding: 40px;
    display: flex;
    flex-direction: column; /* 수직 정렬 */
    gap: 30px;
  }

  /* 게시물 섹션 */
  .post-section {
    background: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 0 12px rgba(0,0,0,0.06);
    width: 100%;
  }

  /* 게시물 테이블 스타일 */
  #post table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 10px; /* 행 간격 */
    table-layout: fixed;
    word-break: break-word;
  }

  #post th, #post td {
    padding: 12px 15px;
    text-align: left;
    vertical-align: top;
    border-bottom: none;
    background-color: #f9f9f9; /* 왼쪽 셀 배경 동일하게 연한 회색으로 통일 */
    color: #333;
    border-radius: 6px;
  }

  #post th {
    width: 120px;
    font-weight: 600;
    background-color: #f9f9f9; /* 파란색 배경 제거 */
    color: #555;
  }

  /* a 태그 (첨부파일 링크) */
  #post td a {
    color: #2980b9;
    text-decoration: none;
  }

  #post td a:hover {
    text-decoration: underline;
  }

  /* 버튼 스타일 */
  #post input[type="button"] {
    background-color: #2980b9;
    border: none;
    color: white;
    padding: 8px 18px;
    margin-right: 10px;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 600;
    transition: none; /* 호버 효과 제거 */
  }

  #post input[type="button"]:hover {
    background-color: #2980b9; /* 색깔 유지 */
  }

  /* 삭제 다이얼로그 */
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
    transition: none; /* 호버 효과 제거 */
  }

  #del_dialog button:hover {
    background-color: #e74c3c; /* 색깔 유지 */
  }

  /* 신고 영역 */
  .report {
    background: #fff;
    padding: 25px 30px;
    border-radius: 8px;
    box-shadow: 0 0 12px rgba(0,0,0,0.06);
    width: 100%;
  }

  .comment_list {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .comment_item {
    background: #fafafa;
    border-radius: 8px;
    padding: 20px 25px;
    box-shadow: 0 0 6px rgba(0,0,0,0.05);
    word-break: break-word;
  }

  .comment_nickname {
    font-weight: 600;
    margin-bottom: 10px;
    color: #333;
  }

  .comment_content {
    font-size: 16px;
    color: black;
    white-space: pre-wrap; /* 줄바꿈 유지 */
  }

  hr {
    border: none;
    border-top: 1px solid #eee;
    margin-top: 10px;
  }


</style>

<body>

<c:import url="/common/adminSidebar.jsp"/>


<div class="main_content">
<section class="post-section">
  <h1>게시물 관리 - 게시글 보기</h1>

  <c:set var="vo" value="${requestScope.vo}"/>
  <c:set var="pvo" value="${requestScope.pvo}"/>

<%--<p>pvo 객체: ${pvo}</p>--%>
<%--  <p>파일명: ${pvo.file_name_original}</p>--%>

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
          <th>별명:</th>
          <td>${vo.member_nickname}</td>
        </tr>

        <tr>
          <th>내용:</th>
          <td>${pvo.post_content}</td>
        </tr>


        <tr>
          <td colspan="2">
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
</section>
  <c:if test="${not empty requestScope.comment_list}">
  <div class="comment_list">
    <!-- 댓글이 위에서 아래로 출력됨 -->
    <c:forEach items="${requestScope.comment_list}" varStatus="vs" var="cvo">
      <div id="comment_list">
        <div id="comment_nickname">
            ${cvo.member_nickname} &nbsp;
          | &nbsp;${cvo.comment_updated_at}
          &nbsp;&nbsp; <c:if test="${sessionScope.member.member_idx != member_info.member_idx}">
          <c:set var="comment_idx" value="${cvo.comment_idx}"/>
        </c:if>
        </div>
        <div id="comment_post">
            ${cvo.comment_content}
        </div>
      </div>
      <hr/>
    </c:forEach>
    </c:if>
<section class="report">
    <c:if test="${not empty rvo}">
      <div class="comment_list">
        <c:forEach items="${rvo}" var="cvo">
          <c:if test="${cvo.post_idx == param.post_idx}">
            <div class="comment_item">
              <div class="comment_nickname">
                  ${cvo.reporter_nickname} → ${cvo.reported_nickname}
              </div>
              <div class="comment_content">
                  ${cvo.report_content}
              </div>
              <hr/>
            </div>
          </c:if>
        </c:forEach>
      </div>
    </c:if>
</section>
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
    document.ff.type.value = "adminpost";
    document.ff.submit();
  }

  function openDel() {
    $("#del_dialog").dialog("open");
  }

  function goDel() {
    document.ff.action = "AdminController";
    document.ff.type.value = "adminpostdel";
    document.ff.submit();
  }

  function goEdit() {
    document.ff.action = "AdminController";
    document.ff.type.value = "adminpostedit";
    document.ff.submit();
  }
</script>

</body>
</html>
