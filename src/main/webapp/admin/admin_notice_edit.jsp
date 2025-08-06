<%@ page import="toour.post.vo.PostVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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

  <!-- 메뉴 -->
  <a href="AdminController">🏠 HOME</a>
  <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
  <a href="product_list.jsp?category=sp003">📝 게시물 관리</a>
  <a href="product_list.jsp?category=sp003">🍽 관광지/맛집 관리</a>
  <a href="product_list.jsp?category=sp003">🗺 관광코스 관리</a>
  <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
</div>

<div class="main-content">
  <h1>관리자 페이지</h1>
</div>

<script type="text/javascript">
  function sendData(){

    let post_title = $("#post_title").val();
    if(post_title.trim().length < 1){
      alert("제목을 입력하세요");
      $("#post_title").val("");
      $("#post_title").focus();
      return;
    }

    let member_idx = $("#member_idx").val();
    if(member_idx.trim().length < 1){
      alert("글쓴이를 입력하세요");
      $("#member_idx").val("");
      $("#member_idx").focus();
      return;
    }

    let post_content= $("#post_content").val();
    if(post_content.trim().length < 1){
      alert("내용을 입력하세요");
      $("#post_content").val("");
      $("#post_content").focus();
      return;
    }

    document.forms[0].submit();
  }
</script>
</head>

<%
  Object obj = request.getAttribute("vo");
  if(obj != null){
    PostVO vo = (PostVO) obj;
%>
<div id="post">
  <form action="Controller?type=adminnoticeedit" method="post"
        encType="multipart/form-data">
    <input type="hidden" name="category_idx" value="2"/>
    <input type="hidden" name="post_idx" value="${param.post_idx}"/>
    <input type="hidden" name="cPage" value="${param.cPage}"/>
    <table summary="게시판 수정">
      <caption>게시판 수정</caption>
      <tbody>
      <tr>
        <th>제목:</th>
        <td><input type="text" name="Post_title" id="Post_title" size="45" value="<%=vo.getPost_title()%>"/></td>
      </tr>
      <tr>
        <th>이름:</th>
        <td><input type="text" value="<%=vo.getPost_idx()%>"
                   name="Post_title" id="Post_title" size="12" disabled/></td>
      </tr>
      <tr>
        <th>내용:</th>
        <td><textarea name="Post_content" cols="50"
                      id="Post_content" rows="8"><%=vo.getPost_content()%></textarea></td>
      </tr>

      <tr>
        <td colspan="2">
          <input type="button" value="수정"
                 onclick="sendData()"/>
          <input type="button" value="취소" onclick="goBack()"/>
          <input type="button" value="목록" onclick="location.href = 'Controller?type=adminnotice'" />
        </td>
      </tr>
      </tbody>
    </table>
  </form>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="../js/summernote-lite.js"></script>
<script src="../js/lang/summernote-ko-KR.js"></script>
<script>
  $(function (){

    $("#content").summernote({
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
      url: "Controller?type=saveImg",
      data: frm,
      type: "post",
      contentType: false,
      processData: false,
      dataType: "json"
    }).done(function (res){
      $("#content").summernote("editor.insertImage", res.img_url);
    });
  }

  function goBack() {
    // Controller?type=view&b_idx=5&cPage=1
    location.href="AdminController?type=adminnoticeview&b_idx=${param.post_idx}&cPage=${param.cPage}";
  }

</script>
<%
  }//if문의 끝
%>
</body>
</html>
