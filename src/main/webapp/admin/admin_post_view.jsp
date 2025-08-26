<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      display: flex;
      background-color: #f4f6f8;
      flex-direction: row;
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
    .main_content {
      flex: 1;
      padding: 40px;
      display: flex;
      flex-direction: column;
      gap: 30px;
    }
    .post-section {
      background: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 0 12px rgba(0,0,0,0.06);
      width: 100%;
    }
    #post table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 10px;
      table-layout: fixed;
      word-break: break-word;
    }
    #post th, #post td {
      padding: 12px 15px;
      text-align: left;
      vertical-align: top;
      border-bottom: none;
      background-color: #f9f9f9;
      color: #333;
      border-radius: 6px;
    }
    #post th {
      width: 120px;
      font-weight: 600;
      background-color: #f9f9f9;
      color: #555;
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
      transition: none;
    }
    #post input[type="button"]:hover {
      background-color: #2980b9;
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
      transition: none;
    }
    #del_dialog button:hover {
      background-color: #e74c3c;
    }
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
      white-space: pre-wrap;
    }
    hr {
      border: none;
      border-top: 1px solid #eee;
      margin-top: 10px;
    }
    .comment {
      border: 1px solid #ddd;
      padding: 8px;
      margin-bottom: 5px;
      border-radius: 5px;
    }
    .comment.reported {
      border: 2px solid red;
      background-color: #ffe6e6;
    }
    .comment.resolved {
      border: 2px solid green;
      background-color: #e6ffe6;
    }
    .comment.highlight {
      box-shadow: 0 0 5px 2px yellow;
    }
    .badge {
      font-size: 12px;
      padding: 2px 5px;
      border-radius: 3px;
      margin-left: 10px;
    }
    .badge.unprocessed {
      background: red;
      color: white;
    }
    .badge.processed {
      background: green;
      color: white;
    }
  </style>
</head>
<body>
<c:import url="/common/adminSidebar.jsp"/>
<div class="main_content">
  <section class="post-section">
    <h1>게시물 관리 - 게시글 보기</h1>
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
            <td>
              <a href="#">
                <c:if test="${empty pvo.file_name_original}">
                  첨부파일 없음
                </c:if>
                <c:if test="${not empty pvo.file_name_original}">
                  ${pvo.file_name_original}
                </c:if>
              </a>
            </td>
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
        <form action="AdminController" method="post">
          <p>정말로 삭제 하시겠습니까?</p>
          <input type="hidden" name="type" value="adminpostdel"/>
          <input type="hidden" name="post_idx" value="${vo.getPost_idx()}"/>
          <input type="hidden" name="cPage" value="${param.cPage}"/>
          <button type="button" onclick="goDel()">삭제</button>
        </form>
      </div>
    </div>
  </section>

  <c:if test="${not empty requestScope.PostReportAr}">
    <div class="report-section">
      <h2>게시글 신고 내역</h2>
      <div class="report-list">
        <c:forEach items="${requestScope.PostReportAr}" var="report">
          <div class="report-item">
            <strong>신고 사유-</strong> ${report.report_content}
            <span class="badge ${report.report_status eq 0 ? 'unprocessed' : 'processed'}">
                ${report.report_status eq 0 ? '대기' : '처리완료'}
            </span>
          </div>
        </c:forEach>
      </div>
    </div>
  </c:if>

  <div class="comment_list">
    <h2>댓글</h2>
    <c:if test="${empty requestScope.commentList}">
      <p>댓글이 없습니다.</p>
    </c:if>
    <c:if test="${not empty requestScope.commentList}">
      <c:forEach items="${requestScope.commentList}" var="cvo">
        <div class="comment
                        <c:if test="${cvo.report_status == 0}">reported</c:if>
                        <c:if test="${cvo.report_status == 1}">resolved</c:if>
                    ">
          <div class="comment_nickname">
              ${cvo.member_nickname} | ${cvo.comment_updated_at}
            <c:if test="${cvo.report_status != null}">
              <button type="button" onclick="falsereport(${cvo.report_idx})">억지신고</button>

                <form action="AdminController" method="post">
                  <input type="hidden" name="type" value="adminpostviewpluswarning"/>
                  <input type="hidden" name="report_idx" value="${cvo.report_idx}"/>
                <button type="submit">경고횟수추가</button>



                                <span class="badge ${cvo.report_status eq 0 ? 'unprocessed' : 'processed'}">
                                    ${cvo.report_status eq 0 ? '대기' : '처리완료'}
                                </span>
            </c:if>
          </div>
          <div class="comment_content">
              ${cvo.comment_content}
          </div>
          <c:if test="${not empty cvo.all_report_contents}">
            <div class="report_reason">
              <strong>신고 사유:</strong><br>
              <c:set var="reportHtml" value="${fn:replace(cvo.all_report_contents, '&#x000A;', '<br>')}"/>
                ${reportHtml}
            </div>
          </c:if>
        </div>
        <hr/>
      </c:forEach>
    </c:if>
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

  function falsereport() {

  }


</script>
</body>
</html>