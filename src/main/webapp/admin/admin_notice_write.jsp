<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 페이지</title>
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="../css/summernote-lite.css"/>
  <style>
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      display: flex;
      background-color: #f4f6f8;
      font-size: 14px;
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
      padding: 40px 50px;
      background-color: white;
      box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
      border-radius: 6px;
      margin: 20px;
      font-size: 14px;
      max-width: 900px;
    }

    table {
      width: 100%;
      border-collapse: separate;
      background: none;
    }

    h1.page-title {
      font-size: 32px;
      font-weight: bold;
      color: #000000;
      margin-bottom: 30px;
    }

    table caption {
      font-weight: 600;
      font-size: 18px;
      margin-bottom: 15px;
      color: #000000;
      text-align: left;
    }

    th {
      width: 100px;
      text-align: left;
      vertical-align: top;
      padding: 10px 15px 10px 0;
      font-weight: 600;
      color: #333;
    }

    td {
      padding: 8px 15px;
      background: #f9fafb;
      border-radius: 5px;
    }

    input[type="text"], textarea, input[type="file"] {
      width: 100%;
      padding: 8px 12px;
      font-size: 14px;
      border: 1px solid #cbd5e1;
      border-radius: 5px;
      box-sizing: border-box;
      font-family: 'Noto Sans KR', sans-serif;
      resize: vertical;
    }

    input[readonly] {
      background-color: #e2e8f0;
      cursor: not-allowed;
    }

    input[type="button"], input[type="reset"] {
      background-color: #2563eb;
      border: none;
      color: white;
      font-weight: 600;
      padding: 8px 18px;
      border-radius: 5px;
      cursor: pointer;
      margin-right: 10px;
      font-size: 14px;
      transition: background-color 0.3s;
    }

    input[type="button"]:hover, input[type="reset"]:hover {
      background-color: #1d4ed8;
    }

    input[type="reset"] {
      background-color: #64748b;
    }

    input[type="reset"]:hover {
      background-color: #4b5563;
    }

    #post_content {
      min-height: 300px;
      font-size: 14px;
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
  <button type="button" onclick='location.href="Controller?type=login"'>로그아웃</button>
</div>

<div class="main-content">
  <h1 class="page-title">관리자 페이지 - 공지사항 글쓰기</h1>


<div id="post">
  <form action="AdminController?type=adminnoticewrite" method="post" encType="multipart/form-data">
    <input type="hidden" name="category_idx" value="1"/>
    <input type="hidden" name="member_idx" value="1"/>


    <table summary="공지사항 글쓰기">
      <tbody>
      <tr>
        <th>제목:</th>
        <td><input type="text" name="post_title" id="post_title" size="45"/></td>
      </tr>
      <tr>
        <th>이름:</th>
        <td><input type="text" name="member_name" id="member_name" size="12" value="관리자" readonly/></td>
      </tr>
      <tr>
        <th>내용:</th>
        <td><textarea name="post_content" cols="50" id="post_content" rows="8"></textarea></td>
      </tr>
      <tr>
        <th>첨부파일:</th>
        <td><input type="file" id="file" name="file"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" value="등록" onclick="sendData()"/>
          <input type="reset" value="초기화" onclick="resetForm()"/>
          <input type="button" value="목록" onclick="location.href='AdminController?type=adminnotice'"/>
        </td>
      </tr>
      </tbody>
    </table>
  </form>
</div>
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
          // console.log(files.length);
        }
      }
    });

  });

  function resetForm() {
    // form 필드 초기화
    document.forms[0].reset();
    // summernote 에디터 내용 초기화
    $('#post_content').summernote('reset');
  }

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
    }).done(function(res) {
      $("#post_content").summernote("editor.insertImage", res.img_url);
    });
  }
  function sendData(){

    let title = $("#post_title").val();
    if(title.trim().length < 1){
      alert("제목을 입력하세요");
      $("#post_title").val("");
      $("#post_title").focus();
      return;
    }

    let content= $("#post_content").val();
    if(content.trim().length < 1){
      alert("내용을 입력하세요");
      $("#post_content").val("");
      $("#post_content").focus();
      return;
    }

    document.forms[0].submit();
  }
</script>
</body>
</html>
