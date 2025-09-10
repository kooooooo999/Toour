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
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">

  <style type="text/css">
    /* 여행후기 제목 스타일 */
    #post h2 {
      text-align: center;
      font-size: 26px; /* 제목 크기 설정 */
      font-weight: bold;
      padding-top: 35px; /* padding으로 위쪽 공간 확보 */
      margin-bottom: 20px; /* 아래쪽 여백 추가 */
      color: #333; /* 색상 설정 */
    }
    /* 테이블 스타일 */
    #post table {
      width: 100%;
      max-width: 1200px;
      margin: 30px auto;
      border-collapse: collapse;
      font-size: 14px;
      background-color: #f9f9f9;
    }

    /*#post table caption {*/
    /*  font-size: 20px;*/
    /*  font-weight: bold;*/
    /*  padding: 10px;*/
    /*  text-align: center;*/
    /*}*/

    #post th {
      background-color: #e0e7f1;
      padding: 10px;
      text-align: left; /* 제목을 왼쪽 정렬 */
    }

    #post td {
      padding: 10px;
      text-align: left; /* 입력란과 내용 왼쪽 정렬 */
    }

    #post td input[type="text"],
    #post td input[type="password"],
    #post td input[type="file"],
    #post td textarea {
      width: 100%;
      padding: 8px;
      border: 1px solid #ccc;
      font-size: 14px;
      border-radius: 5px;
      margin-top: 5px;
    }

    #post td input[type="text"]:focus,
    #post td input[type="password"]:focus,
    #post td textarea:focus {
      outline: none;
      border-color: #007bff;
    }

    #post td input[type="file"] {
      width: auto;
      border: none; /* border를 제거 */
    }

    #post input[type="submit"],
    #post input[type="reset"],
    #post input[type="button"] {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 10px 20px;
      margin: 10px 5px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 14px;
    }

    #post input[type="submit"]:hover,
    #post input[type="reset"]:hover,
    #post input[type="button"]:hover {
      background-color: #0056b3;
    }

    /*#post caption {*/
    /*  background-color: #f1f1f1;*/
    /*  color: #333;*/
    /*  padding: 10px;*/
    /*  font-size: 22px;*/
    /*  font-weight: bold;*/
    /*}*/

    #post td img {
      margin-right: 10px;
    }

    /* 제목 입력란 길이 늘리기 */
    #post td input[type="text"] {
      width: 100%; /* 제목 입력란의 길이를 100%로 늘림 */
      padding: 8px;
      border: 1px solid #ccc;
      font-size: 14px;
      border-radius: 5px;
      margin-top: 5px;
    }

    /* 텍스트 영역 스타일 */
    #post td textarea {
      height: 150px;
      resize: vertical;
    }

    /* 글쓰기 버튼의 배치 */
    #post td input[type="submit"],
    #post td input[type="reset"],
    #post td input[type="button"] {
      display: inline-block;
      margin-top: 15px;
    }

    body {
      margin: 0;
      padding: 0;
    }

    .paging-area {
      margin-bottom: 0 !important;
      padding-bottom: 0 !important;
    }

    footer {
      margin-top: 0 !important;
    }

    .star-rating .star {
      font-size: 22px;
      cursor: pointer;
      color: lightgray;
    }
    .star-rating .star.selected {
      color: gold;
    }

  </style>
  <script type="text/javascript">

  </script>
</head>
<body>
<c:import url="/common/header.jsp" />


<%-- 로그인하지 않았을 때 보여줄 내용 --%>
<c:if test="${empty sessionScope.member}">
  <h3>로그인이 필요합니다.</h3>
  <p>
    <a href="Controller?type=moveLogin">로그인</a>
    또는
    <a href="Controller?type=moveSignup">회원가입</a>을 해주세요.
  </p>
</c:if>

<c:if test="${not empty sessionScope.member}">

  <div id="post">
    <h2>여행후기</h2>
    <form action="Controller?type=write" method="post"
          encType="multipart/form-data" onsubmit="return sendData()">
      <input type="hidden" name="category_idx" value="2"/>
      <table summary="게시판 글쓰기">
<%--        <caption>게시판 글쓰기</caption>--%>
        <tbody>
        <tr>
          <th>제목:</th>
          <td><input type="text" name="post_title" id="post_title" size="45"/></td>
        </tr>
        <tr>
          <th>이름:</th>
          <td>${sessionScope.member.member_nickname}</td>
        </tr>
        <tr>
          <th>별점:</th>
          <td>
            <div class="star-rating">
              <span class="star" data-value="1">★</span>
              <span class="star" data-value="2">★</span>
              <span class="star" data-value="3">★</span>
              <span class="star" data-value="4">★</span>
              <span class="star" data-value="5">★</span>
            </div>
            <input type="hidden" name="post_rating" id="post_rating" value="0"/>
          </td>
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

        <tr>
          <td colspan="2">
            <input type="submit" value="등록" />
            <input type="reset" value="다시" onclick="resetForm()"/>
            <input type="button" value="목록" onclick="location.href='Controller?type=list'"/>
          </td>
        </tr>
        </tbody>
      </table>
    </form>
  </div>
</c:if>


<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script src="../js/summernote-lite.js"></script>
<script src="../js/lang/summernote-ko-KR.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
<script>
  // $(function (){
  //
  //   $("#post_content").summernote({
  //     lang: "ko-KR",
  //     height: 500,
  //     callbacks: {
  //       onImageUpload: function(files, editor){
  //         // 에디터에 이미지를 추가될 때 수행하는 곳!
  //         // 이미지는 여러 개 추가할 수 있으므로 files는 배열이다.
  //         for(let i=0; i<files.length; i++)
  //           sendImg(files[i], editor);
  //         //console.log(files.length);
  //       },
  //       onImageUploadError: function(msg) {
  //         console.error('이미지 업로드 오류:', msg);
  //         alert('이미지 업로드에 실패했습니다: ' + msg);
  //       }
  //     }
  //   });
  //
  // });
  //
  // function resetForm() {
  //   // form 필드 초기화
  //   document.forms[0].reset();
  //   // summernote 에디터 내용 초기화
  //   $('#post_content').summernote('reset');
  // }
  //
  // function sendImg(file, editor) {
  //   //서버로 비동기식 통신을 수행하기 위해 준비한다.
  //   // 이미지를 서버로 보내기위해 폼객체를 생성하자!
  //   let frm = new FormData();
  //
  //   // 서버로 보낼 이미지파일을 폼객체에 파라미터로 지정
  //   frm.append("upload", file);
  //
  //   //비동기식 통신
  //   $.ajax({
  //     url: "Controller?type=saveImg",
  //     data: frm,
  //     type: "post",
  //     contentType: false,
  //     processData: false,
  //     dataType: "json"
  //   }).done(function(res) {
  //     // $("#post_content").summernote("editor.insertImage", res.img_url);
  //     //클라이언트에서 삽입하는 이미지 URL을 절대경로로 보정
  //     let imgURL = res.img_url;
  //
  //     if (!imgURL.startsWith("http")) {
  //       imgURL = window.location.origin + imgURL;
  //     }
  //     $("#post_content").summernote("editor.insertImage", imgURL);
  //
  //   }).fail(function(xhr, status, error) {
  //     console.error('이미지 업로드 실패:', xhr.responseText);
  //     alert('이미지 업로드에 실패했습니다: ' + error);
  //   });
  // }

  $(document).ready(function() {
    // Summernote 에디터 초기화
    $('#post_content').summernote({
      height: 300, // 에디터 높이 설정
      lang: 'ko-KR', // 한국어 설정
      callbacks: {
        // 이미지 업로드 처리
        onImageUpload: function(files) {
          // 이미지를 Cloudinary로 업로드
          var data = new FormData();
          data.append("file", files[0]); // 업로드된 파일 추가
          data.append("upload_preset", "testtest"); // Cloudinary 업로드 프리셋

          // 비동기식 이미지 업로드
          $.ajax({
            url: 'https://api.cloudinary.com/v1_1/dqkajtq62/image/upload',
            method: 'POST',
            data: data,
            contentType: false,
            processData: false,
            success: function(response) {
              // 업로드된 이미지 URL
              var imageUrl = response.secure_url;

              // 에디터에 이미지 삽입
              $('#post_content').summernote('insertImage', imageUrl);
            },
            error: function(xhr, status, error) {
              console.error('이미지 업로드 실패:', error);
              alert('이미지 업로드에 실패했습니다.');
            }
          });
        }
      }
    });
  });

  function sendData(){

    let title = $("#post_title").val();
    if(title.trim().length < 1){
      alert("제목을 입력하세요");
      $("#post_title").val("");
      $("#post_title").focus();
      return false;
    }

    let content= $("#post_content").val();
    if(content.trim().length < 1){
      alert("내용을 입력하세요");
      $("#post_content").val("");
      $("#post_content").focus();
      return false;
    }
    //유효성 검사 통과시 폼제출!
    return true;
  }

  // 별점 클릭 이벤트
  document.querySelectorAll(".star-rating .star").forEach(star => {
    star.addEventListener("click", function() {
      let value = this.getAttribute("data-value");
      document.getElementById("post_rating").value = value; // hidden에 저장

      // 선택한 별까지 색칠
      this.parentNode.querySelectorAll(".star").forEach(s => {
        if (s.getAttribute("data-value") <= value) {
          s.classList.add("selected");
        } else {
          s.classList.remove("selected");
        }
      });
    });
  });

</script>
<c:import url="/common/footer.jsp" />

</body>
</html>













