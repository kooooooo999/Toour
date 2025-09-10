<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        #post h2 {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            padding-top: 35px;
            margin-bottom: 20px;
            color: #333;
        }

        #post table {
            width: 100%;
            max-width: 1200px;
            margin: 30px auto;
            border-collapse: collapse;
            font-size: 14px;
            background-color: #f9f9f9;
        }

        #post th {
            background-color: #e0e7f1;
            padding: 10px;
            text-align: left;
        }

        #post td {
            padding: 10px;
            text-align: left;
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

        /* 텍스트 영역 스타일 */
        #post td textarea {
            height: 150px;
            resize: vertical;
        }

        #post td input[type="file"] {
            width: auto;
            border: none;
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

        #post_content{
          height: 500px;
        }

        #post input[type="submit"]:hover,
        #post input[type="reset"]:hover,
        #post input[type="button"]:hover {
            background-color: #0056b3;
        }

        #post td img {
            margin-right: 10px;
        }

        .paging-area {
            margin-bottom: 0 !important;
            padding-bottom: 0 !important;
        }

        footer {
            margin-top: 0 !important;
        }

        .file-item {
            margin: 5px 0;
        }

        .file-item a {
            font-size: 14px;
            color: #007bff;
        }

        .file-item label {
            margin-left: 10px;
            font-size: 14px;
        }

        .post-actions {
            text-align: right;
            margin-top: 20px;
        }

        .post-actions input[type="submit"],
        .post-actions input[type="button"] {
            padding: 10px 20px;
            font-size: 14px;
            cursor: pointer;
        }

        .post-actions input[type="submit"]:hover,
        .post-actions input[type="button"]:hover {
            background-color: #0056b3;
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

</head>
<body>

<c:import url="/common/header.jsp" />

<c:if test="${empty sessionScope.member}">
    <h3>로그인이 필요합니다.</h3>
    <p>
        <a href="Controller?type=moveLogin">로그인</a>
        또는
        <a href="Controller?type=moveSignup">회원가입</a>을 해주세요.
    </p>
</c:if>

<c:if test="${not empty sessionScope.member}">
    <c:set var="vo" value="${requestScope.vo}" scope="page"/>
    <c:set var="filevo" value="${requestScope.filevo}" scope="page"/>
    <c:set value="${requestScope.cPage}" var="cPage"/>

    <div id="post">
        <h2>게시글 수정</h2>
        <form name="editForm" action="Controller?type=edit" method="post"
              onsubmit="return sendData()">
            <input type="hidden" name="category_idx" value="2"/>
            <input type="hidden" name="post_idx" value="${vo.post_idx}"/>
            <input type="hidden" name="cPage" value="${cPage}"/>
            <table>
                <caption>게시판 수정</caption>
                <tbody>
                <tr>
                    <th>제목:</th>
                    <td><input type="text" name="post_title" id="post_title" size="45" value="${vo.post_title}"/></td>
                </tr>
                <tr>
                    <th>이름:</th>
                    <td><input type="text" value="${sessionScope.member.member_nickname}"
                               name="member_nickname" id="member_nickname" size="12" readonly/></td>
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
                    <td><textarea name="post_content" cols="50" id="post_content" rows="8">${vo.post_content}</textarea></td>
                </tr>

                <tr>
                    <td colspan="2">
                        <div class="post-actions">
                            <input type="submit" value="수정" class="btn primary"/>
                            <input type="button" value="취소" onclick="goBack()" class="btn ghost"/>
                            <input type="button" value="목록" onclick="location.href='Controller?type=list'" class="btn"/>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
</c:if>

<c:import url="/common/footer.jsp" />

<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
<script src="../js/lang/summernote-ko-KR.js"></script>
<script>
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
                            console.log("Cloudinary response: "+response); // 업로드 응답 찍어보기
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
    function sendData() {
        let title = $("#post_title").val();
        if (title.trim().length < 1) {
            alert("제목을 입력하세요");
            $("#post_title").focus();
            return false;
        }

        let content = $("#post_content").summernote("code");  // 여기 수정
        if (content.trim().length < 1) {
            alert("내용을 입력하세요");
            $("#post_content").summernote("focus");
            return false;
        }
        $("#post_content").val(content);
        //유효성 검사 통과시 폼제출!
        return true;
    }

    function sendImg(file, editor) {
        let frm = new FormData();
        frm.append("upload", file);

        $.ajax({
            url: "Controller?type=saveImg",
            data: frm,
            type: "post",
            contentType: false,
            processData: false,
            dataType: "json"
        }).done(function(res){
            // Ensure that your server response is a JSON object with a key like "img_url"
            // and that it contains the URL of the saved image.
            $("#post_content").summernote("editor.insertImage", res.img_url);
        });
    }

    function goBack() {
        let post_idx = $('input[name="post_idx"]').val();
        let cPage = $('input[name="cPage"]').val();
        location.href = `Controller?type=view&post_idx=${post_idx}&cPage=${cPage}`;
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

</body>
</html>
