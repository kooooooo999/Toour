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
              enctype="multipart/form-data" onsubmit="return sendData()">
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
                    <th>내용:</th>
                    <td><textarea name="post_content" cols="50" id="post_content" rows="8">${vo.post_content}</textarea></td>
                </tr>

                <tr>
                    <th>첨부파일:</th>
                    <td>
                        <c:if test="${not empty requestScope.file}">
                            <c:forEach var="file" items="${requestScope.file}">
                                <div class="file-item">
                                    <a href="<c:url value="/bbs_upload/${file.file_name_stored}" />">${file.file_name_original}</a>
                                    <label><input type="checkbox" name="deleteFile" value="${file.file_idx}"/> 삭제</label>
                                </div>
                            </c:forEach>
                        </c:if>

                        <div class="file-item">
                            <label for="file">새 파일 첨부:</label>
                            <input type="file" id="file" name="file"/>
                        </div>
                    </td>
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
<script src="../js/summernote-lite.js"></script>
<script src="../js/lang/summernote-ko-KR.js"></script>
<script>
    $(function (){
        $("#post_content").summernote({
            lang: "ko-KR",
            height: 300,
            callbacks: {
                onImageUpload: function(files, editor){
                    // 이미지를 서버에 업로드
                    for(let i=0; i<files.length; i++)
                        sendImg(files[i], editor);
                }
            }
        });
    });

    function sendData() {
        let title = $("#post_title").val();
        if (title.trim().length < 1) {
            alert("제목을 입력하세요");
            $("#post_title").val("");
            $("#post_title").focus();
            return false;
        }

        let content = $("#post_content").val();
        if (content.trim().length < 1) {
            alert("내용을 입력하세요");
            $("#post_content").val("");
            $("#post_content").focus();
            return false;
        }
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
            $("#post_content").summernote("editor.insertImage", res.img_url);
        });
    }

    function goBack() {
        let post_idx = $('input[name="post_idx"]').val();
        let cPage = $('input[name="cPage"]').val();
        location.href = `Controller?type=view&b_idx=${post_idx}&cPage=${cPage}`;
    }
</script>

</body>
</html>
