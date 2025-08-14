1 <%@ page import="toour.post.vo.PostVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="../css/summernote-lite.css"/>
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/post.css" />">

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
        .t_bold{ font-weight: bold; color: #007bff; }

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
    <form name="editForm" action="Controller?type=edit" method="post"
          encType="multipart/form-data" onsubmit="return sendData()">
        <<input type="hidden" name="category_idx" value="2"/>
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
                        <%-- Check if a list of files exists --%>
                    <c:if test="${not empty requestScope.file}">
                        <%-- Loop through each file in the list --%>
                        <c:forEach var="file" items="${requestScope.file}">
                            <div>
                                    <%-- Use the 'file' variable from the loop to get each file's data --%>
                                <a href="<c:url value="/bbs_upload/${file.file_name_stored}" />">${file.file_name_original}</a>
                                <label>
                                    <input type="checkbox" name="deleteFile" value="${file.file_idx}"/> 삭제
                                </label>
                            </div>
                        </c:forEach>
                    </c:if>

                    <div>
                        <label for="file">새 파일 첨부:</label>
                        <input type="file" id="file" name="file"/>
                    </div>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <input type="submit" value="수정"/>
                    <input type="button" value="취소" onclick="goBack()"/>
                    <input type="button" value="목록" onclick="location.href='Controller?type=list'"/>
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
                    // 에디터에 이미지를 추가될 때 수행하는 곳!
                    // 이미지는 여러 개 추가할 수 있으므로 files는 배열이다.
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













