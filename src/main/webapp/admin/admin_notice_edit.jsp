<%@ page import="toour.post.vo.PostVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 페이지</title>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="../css/summernote-lite.css"/>
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

    input[readonly] {
      background-color: #e0e0e0;
      color: #555555;
      border: 1px solid #ccc;
      font-weight: bold;
      padding: 5px 8px;
      border-radius: 4px;
    }
  </style>
</head>
<body>
<div class="sidebar">

  <!-- 메뉴 -->
  <a href="AdminController">🏠 HOME</a>
  <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
  <a href="AdminController?type=adminpost">📝 게시물 관리</a>
  <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
</div>

<div class="main-content">
  <h1>관리자 페이지</h1>
</div>

<script type="text/javascript">
  function sendData(){
    $("#post_content").val($("#post_content").summernote("code"));

    let post_title = $("#post_title").val();
    if(post_title.trim().length < 1){
      alert("제목을 입력하세요");
      $("#post_title").val("");
      $("#post_title").focus();
      return;
    }

    let post_content= $("#post_content").val();
    if(post_content.trim().length < 1){
      alert("내용을 입력하세요");
      $("#post_content").val("");
      $("#post_content").focus();
      return;
    }

    document.getElementById("editform").submit();
  }
</script>
<%--</body>--%>

<c:set var="vo" value="${requestScope.vo}" scope="page"/>

<div id="post">
  <form id="editform" action="AdminController?type=adminnoticeedit" method="post" enctype="multipart/form-data">
    <input type="hidden" name="category_idx" value="2"/>
    <input type="hidden" name="post_idx" value="${param.post_idx}"/>
    <input type="hidden" name="cPage" value="${param.cPage}"/>
    <table summary="공지사항 수정">
      <caption>공지사항 수정</caption>
      <tbody>
      <tr>
        <th>제목:</th>
        <td><input type="text" name="post_title" id="post_title" size="45" value="${vo.post_title}"/></td>
      </tr>
      <tr>
        <th>이름:</th>
        <td><input type="text" value="관리자"
                   name="member_name" id="member_name" size="12" readonly/></td>
      </tr>
      <tr>
        <th>내용:</th>
        <td><textarea name="post_content" cols="50"
                      id="post_content" rows="8">${vo.post_content}</textarea></td>
      </tr>
      <tr>
        <th>첨부파일:</th>
          <td><input id="file" type="file" name="file"></td>
        <c:if test="${vo.file_name_original != null}">
          <p class="t_bold">${vo.file_name_original}</p>
        </c:if>
      </tr>

      <tr>
        <td colspan="2">
          <input type="button" value="수정" onclick="sendData()"/>
          <input type="button" value="취소" onclick="location.href = 'AdminController?type=adminnoticeview&post_idx=${param.post_idx}&cPage=${param.cPage}'"/>
          <input type="button" value="목록" onclick="location.href='AdminController?type=adminnotice'" />
        </td>
      </tr>
      </tbody>
    </table>
  </form>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script src="../js/summernote-lite.js"></script>
<script src="../js/lang/summernote-ko-KR.js"></script>

<script>
  $(function (){

    $("#post_content").summernote({
      lang: "ko-KR",
      height: 300,
      callbacks: {
        onImageUpload: function(files, editor){
          // 에디터에 이미지를 추가될 때 수행하는 곳!
          // 이미지는 여러 개 추가할 수 있으므로 files는 배열이다.
          for(let i=0; i<files.length; i++)
            sendImg(files[i], editor);
        }
      }
    });

  });

  function sendImg(file, editor) {
    //서버로 비동기식 통신을 수행하기 위해 준비한다.
    // 이미지를 서버로 보내기위해 폼객체를 생성하자!
    let frm = new FormData();

    // 서버로 보낼 이미지파일을 폼객체에 파라미터로 지정
    frm.append("upload", file);

    //비동기식 통신
    $.ajax({
      url: "AdminController?type=adminnoticesaveimg",
      data: frm,
      type: "post",
      contentType: false,
      processData: false,
      dataType: "json"
    }).done(function (res){
      $("#post_content").summernote("editor.insertImage", res.img_url);
    });
  }
</script>
</body>
</html>
