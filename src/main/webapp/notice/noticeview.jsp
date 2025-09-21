<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="toour.post.vo.PostVO" %>
<%@ page import="toour.post.vo.CommentVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="<c:url value="/css/header.css" />">
    <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
    <link rel="stylesheet" href="<c:url value="/css/post.css" />">

    <style type="text/css">
        #post {
            max-width: 1400px;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px !important;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            overflow-x: auto; /* 테이블이 너무 넓을 경우 스크롤바 생성 */

        }


        #comment_form h3 {
            font-size: 18px;
            margin-bottom: 12px;
            font-weight: 600;
            color: #333;
        }


        .comment_container textarea{
            width: 100%;
            flex-grow: 1;
            min-height: 150px;
            padding: 16px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            resize: none;
            box-sizing: border-box;
            margin-bottom: 12px;
        }

        .comment_list div {
            margin-bottom: 15px;
            word-break: break-word;
            color: #555;
        }

        .comment_list div b {
            font-weight: 600;
            margin-right: 5px;
        }

        .comment_list hr {
            border: 0;
            border-top: 1px solid #eee;
        }


        /* footer 스타일 */
        footer {
            margin-top: 40px;
            padding: 20px;
            background-color: #eaf3fc;
            text-align: center;
            font-size: 13px;
            color: #666;
            border-radius: 0 0 8px 8px;
        }

        .content-head h3{
            margin-top: 50px;
            color: #e74c3c;
            text-align: center;
        }

        .content-head h1{
            margin-top: 10px;
            color: #222222;
            text-align: center;
        }

        .info{
            margin-top: 5px;
            color: #333333;
            text-align: center;
        }

        .content{
            margin-top: 40px;
            margin-left: 170px;
            margin-bottom: 40px;
            color: #000000;
        }

        .line {
            color: #666666;
            margin-top: 10px;
            width: 80%;
            margin-left: auto;
            margin-right: auto;
            border-top: 1px solid #cccccc;
        }

        .line2 {
            color: #666666;
            margin-top: 40px;
            margin-bottom: 10px;
            width: 80%;
            margin-left: auto;
            margin-right: auto;
            border-top: 1px solid #cccccc;
        }


        #noticebutton {
            padding: 10px 20px;
            background-color: #0056b3;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 50px;
            margin-right: 140px;
            margin-bottom: 20px;
            float: right; /* 오른쪽 정렬 효과 */

        }

        .attachment {
            display: inline-block;
            padding: 4px 8px;
            background-color: #f0f0f0;
            border-radius: 4px;
            font-size: 12px;
            color: #666;
            float: left;
            margin-left: 140px;
        }

        body {
            margin: 0;
            padding: 0;
        }

        footer {
            margin-top: 0 !important;
        }

        /*.attachment:hover {*/
        /*    border-bottom: 2px solid #333;*/
        /*    !*cursor: pointer;*!*/
        /*    background-color: #e0e0e0;*/
        /*}*/

    </style>

</head>
<body>
<c:import url="/common/header.jsp" />
<c:set value="${sessionScope.member}" var="user"/>
<c:set var="vo" value="${requestScope.vo}"/>
<c:set var="member_info" value="${requestScope.member_info}"/>


<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<div id="post">
    <form method="post" >
        <!-- content head -->
        <div class="content-head">
            <h3 class="h3">공지</h3>
            <h1 class="h1">${vo.post_title}</h1>
            <div class = "info">
                관리자 | ${vo.post_updated_at.substring(0,10)}
            </div>

            <hr class="line">
        </div>
        <div class="content">
            ${vo.post_content}
        </div>
        <hr class="line2">

        <div class="attachment">

            <%--                <tr>--%>
            <%--        <th>첨부파일:</th>--%>
            <%--                    <td colspan="2">--%>
            <c:if test="${not empty requestScope.fileList}">
                <img src="https://cdn-icons-png.flaticon.com/512/724/724933.png" width="20" height="20" alt="첨부파일">
                <c:forEach var="file" items="${requestScope.fileList}">
                    <div>
                        <a href="AdminController?type=adminfiledownload&f_name=${file.file_name_stored}">${file.file_name_original}</a>
                    </div>
                </c:forEach>
            </c:if>
            <%-- Display message if the list of files is empty --%>
            <c:if test="${empty requestScope.fileList}">
                첨부파일 없음
            </c:if>
            <%--                    </td>--%>
            <%--                </tr>--%>
        </div>


        <input id="noticebutton" name="noticebutton" type="button" value="목록" onclick="goNotice()"/>
    </form>

        <form name="ff" method="get">
            <input type="hidden" name="type" />
            <input type="hidden" name="post_idx" value="${vo.getPost_idx()}"/>
            <input type="hidden" name="cPage" value="${param.cPage}"/>
        </form>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>

    <script>
        $(function (){
            let option = {
                modal: true,
                autoOpen: false, // 호출되는 즉시 대화상자 표시(기본값: true)
                resizable: false,
            };

            $("#del_dialog").dialog(option);
        });

        let login = ${sessionScope.member != null};

        function commentData() {
            let title = $("#comment_content").val();
            if (title.trim().length < 1) {
                alert("내용을 입력하세요");
                $("#comment_content").val("");
                $("#comment_content").focus();
                return false;
            }

            if(!login){
                $("#loginDialog").dialog("open");
                return false;
            }

            return true;
        }
        function goNotice() {
            document.ff.action = "Controller";
            document.ff.type.value = "notice";
            document.ff.submit();
        }
        function goDel() {
            /*document.ff.action = "Controller";
            document.ff.type.value = "del"
            document.ff.submit();*/
            $("#del_dialog").dialog("open");
        }
        function del(frm) {
            frm.submit();
        }

        function goEdit() {
            // ff 폼의 action과 type을 설정
            document.ff.action = "Controller";
            document.ff.type.value = "edit";
            document.ff.submit();
        }


        $(function (){
            $("#loginDialog").dialog({
                autoOpen: false,
                modal: true,
                resiazable: false
            });
            // $("#loginDialog").dialog(option);
        });


    </script>
</div>
</body>

<c:import url="/common/footer.jsp" />

</html>













