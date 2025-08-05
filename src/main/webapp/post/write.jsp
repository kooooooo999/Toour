<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <!-- 외부 CSS연결 -->
  <link rel="stylesheet" href="<c:url value="/css/post.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">

  <link rel="stylesheet" href="../css/summernote-lite.css"/>

  <link rel="stylesheet" href="<c:url value="/css/header.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">

  <style type="text/css">
    #post table {
      width:580px;
      margin-left:10px;
      border:1px solid black;
      border-collapse:collapse;
      font-size:14px;

    }

    #post table caption {
      font-size:20px;
      font-weight:bold;
      margin-bottom:10px;
    }

    #post table th {
      text-align:center;
      border:1px solid black;
      padding:4px 10px;
    }

    #post table td {
      text-align:left;
      border:1px solid black;
      padding:4px 10px;
    }

    .no {width:15%}
    .subject {width:30%}
    .writer {width:20%}
    .reg {width:20%}
    .hit {width:15%}
    .title{background:lightsteelblue}

    .odd {background:silver}


  </style>
  <script type="text/javascript">

  </script>
</head>
<body>
<c:import url="/common/header.jsp" />

<div id="post">
  <form action="Controller?type=write" method="post"
        encType="multipart/form-data">
    <input type="hidden" name="category_idx" value="2"/>
    <table summary="게시판 글쓰기">
      <caption>게시판 글쓰기</caption>
      <tbody>
      <tr>
        <th>제목:</th>
        <td><input type="text" name="post_title" id="post_title" size="45"/></td>
      </tr>
      <tr>
        <th>이름:</th>
        <td><input type="text" name="member_idx" id="member_idx" size="12"/></td>
      </tr>
      <tr>
        <th>내용:</th>
        <td><textarea name="post_content" cols="50"
               id="post_content" rows="8"></textarea></td>
      </tr>
      <tr>
        <th>첨부파일:</th>
        <td><input type="file" id="file" name="file"/></td>
      </tr>
      <!--
                      <tr>
                          <th>비밀번호:</th>
                          <td><input type="password" name="pwd" size="12"/></td>
                      </tr>
      -->
      <tr>
        <td colspan="2">
          <input type="button" value="등록" onclick="sendData()"/>
          <input type="reset" value="다시" onclick="resetForm()"/>
          <input type="button" value="목록" onclick="location.href='Controller?type=list'"/>
        </td>
      </tr>
      </tbody>
    </table>
  </form>
</div>

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
          console.log(files.length);
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
      url: "Controller?type=saveImg",
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

    let writer = $("#member_idx").val();
    if(writer.trim().length < 1){
      alert("글쓴이를 입력하세요");
      $("#member_idx").val("");
      $("#member_idx").focus();
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
<c:import url="/common/footer.jsp" />

</body>
</html>













