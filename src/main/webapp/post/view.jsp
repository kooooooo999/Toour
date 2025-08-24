<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style type="text/css">
        #post {
            max-width: 1400px;
            margin: 0 auto;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px !important;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            padding: 0 40px;

        }

        /* 댓글 폼 영역 */
        #comment_form {
            margin-top: 50px;
            padding: 20px 40px;
            width: 100%;
            background-color: #fff;
            border-top: 1px solid #eee;
        }

        #comment_form h3 {
            font-size: 18px;
            margin-bottom: 12px;
            font-weight: 600;
            color: #333;
        }

        /* 댓글 입력 + 리스트 가로 배치 */
        .comment_container {
            display: flex;
            flex-direction: column;
            gap: 10px;
            width: 100%;
            align-items: flex-start;
        }

        .comment_container textarea {
            width: 100%;
            flex-grow: 1;
            min-height: 150px;
            padding: 16px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            resize: none;
            box-sizing: border-box;
        }


        /* 댓글 리스트 영역 */
        .comment_list {
            width: 100%;
            height: auto;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 10px 20px;
            font-size: 14px;
            line-height: 1.5;
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

        .comment_action {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 12px;
            margin-bottom: 10px;
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

        .post-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            font-size: 15px;
        }
        table td:hover {
            background-color: inherit !important;
            color: inherit !important;
        }
        .post-table th, .post-table td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: left;
            vertical-align: top;
        }

        .post-table th {
            background-color: #f0f0f0;
            width: 120px;
        }

        .post-title {
            background-color: #e8f4ff;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
        }

        .post-title th {
            font-size: 24px;
            font-weight: 700;
            background-color: #ffffff;
            padding: 20px;
            text-align: center;
        }

    .post-title td {
      font-size: 20px;
      font-weight: bold;
      padding: 20px;
      background-color: #f9fbfe;
      text-align: center;
    }

        .post-name th {
            text-align: center;
        }

        .post-name td {
            text-align: center;
        }

        .post-content th {
            background-color: #fcfcfc;
            line-height: 1.6;
            padding: 20px;
            text-align: left;
            margin-left: 500px;

        }

        .post-buttons {
            text-align: right;
            margin-right: 40px;
            margin-top: 40px;
        }

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

        .comment_button {
            display: flex;
            justify-content: flex-end;
            width: 100%;
        }

        #comment_btn {
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            color: #fff;
            background-color: #0056b3;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }


        .attachment td {
            background-color: #fefefe;
            padding: 15px;
        }

        .attachment {
            display: inline-block;
            padding: 4px 8px;
            background-color: #f0f0f0;
            border-radius: 4px;
            font-size: 12px;
            color: #666;
            float: left;
            margin-left: 35px;
            margin-top: 10px;
        }

        #comment_lilist {
            margin-left: 20px;
            margin-top: 5px;
            font-size: 16px;
        }

        #comment_nickname {
            font-weight: bold;
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

    #report_dialog{ /* 신고 다이얼로그 */
      display: none; /* 처음에는 숨김 */
    }

    .report-emoji {
      cursor: pointer;
      font-size: 18px;
      transition: transform 0.2s;
    }

    .report-emoji:hover {
      transform: scale(1.2);
    }
        /* 댓글 전체 컨테이너 */
        #dynamic_comment_list {
            margin-top: 20px;
            padding: 10px;
            border-radius: 8px;
            background-color: #f9f9f9;
        }

        /* 각 댓글 항목 */
        .comment-item {
            margin-bottom: 15px;
            padding: 15px;
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }



  </style>

</head>
<body>
<c:import url="/common/header.jsp" />
<c:set value="${sessionScope.member}" var="user"/>
<c:set var="vo" value="${requestScope.vo}"/>
<c:set var="member_info" value="${requestScope.member_info}"/>


<div id="post">
    <form method="post">
        <table summary="게시판 글쓰기" class="post-table">
            <caption>게시판 글쓰기</caption>
            <tbody>
            <tr class="post-title">
                <th colspan="6">${vo.post_title}</th>
            </tr>

            <!--게시물-->
            <tr class="post-name">
                <th>별명</th>
                <td>${member_info.member_nickname}</td>
                <th>작성일</th>
                <td>${vo.post_updated_at}</td>
                <th>조회수</th>
                <td>${vo.post_views}</td>
            </tr>

            <tr class="post-content">
                <th colspan="6" rowspan="6">${vo.post_content}</th>
            </tr>
            </tbody>
        </table>

        <div class="attachment">

        <%--                <tr>--%>
        <%--        <th>첨부파일:</th>--%>
        <%--                    <td colspan="2">--%>
            <c:if test="${not empty requestScope.fileList}">
                <img src="https://cdn-icons-png.flaticon.com/512/724/724933.png" width="20" height="20" alt="첨부파일">
                <c:forEach var="file" items="${requestScope.fileList}">
                    <div>
                        <a href="Controller?type=download&fileName=${file.file_name_stored}" target="_blank">다운로드</a>
                    ${file.file_name_original} 다운로드
                        </a>
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
    </form>
    <div id="heartContainer" style="text-align: center; font-size: 24px; margin: 40px 0;">
        <span style="font-weight: bold; margin-right: 10px;">추천</span>
        <c:choose>
            <c:when test="${requestScope.alreadyRecommended}">
                <i id="heart" class="fa-solid fa-heart" style="cursor:pointer; font-size: 30px; color: red;"></i>
            </c:when>
            <c:otherwise>
                <i id="heart" class="fa-regular fa-heart" style="cursor:pointer; font-size: 30px; color: red;"></i>
            </c:otherwise>
        </c:choose>
        <input type="hidden" name="post_likes" id="likesCount" value="${vo.post_likes}">
        <span id="likesCountDisplay">${vo.post_likes}</span>
        <input type="hidden" id="member_idx" value="${sessionScope.member.member_idx}">
        <input type="hidden" id="post_idx" value="${vo.post_idx}">
    </div>

    <div class="post-buttons">
        <c:if test="${not empty sessionScope.member}">
            <!-- 내가 쓴 글 -->
            <c:if test="${sessionScope.member.member_idx == member_info.member_idx}">
                <input type="button" value="수정" onclick="goEdit()"/>
                <input type="button" value="삭제" onclick="goDel()"/>
            </c:if>

            <!-- 다른 사람이 쓴 글일 때 신고 버튼 -->
            <c:if test="${sessionScope.member.member_idx != member_info.member_idx}">
                <%--            <input type="button" value="신고🚨" onclick="openReportDialog()"/>--%>
                <span class="report-emoji" title="신고하기" onclick="openReportDialog()">🚨</span>
            </c:if>
        </c:if>


        <input type="button" value="목록" onclick="goList()"/>
    </div>

    <!-- 신고 팝업 -->
    <div id="report_dialog" title="게시물 신고">
        <form id="reportForm" action="Controller?type=reportPost" method="post"
     >
            <p>신고 사유를 입력하세요:</p>
            <label><textarea name="reason" id="report_reason" rows="5" style="width:95%; box-sizing:border-box;" required></textarea></label>
            <input type="hidden" name="post_idx" value="${vo.post_idx}"/>
            <input type="hidden" name="reporter_idx" value="${sessionScope.member.member_idx}"/>
            <input type="hidden" name="reported_idx" value="${member_info.member_idx}"/>
        </form>
    </div>

    <!--댓글 작성-->
    <div id="comment_form">
        <h3>댓글</h3>
        <form enctype="multipart/form-data" action="Controller?type=comment" method="post" name="comment_form" onsubmit="return commentData()">
            <div class="comment_container">
                <c:if test="${empty sessionScope.member}">
                    <textarea id="none_comment_content" placeholder="로그인을 하시고 여행의 즐거움이 담긴 후기를 남겨주세요." rows="4" cols="55" name="post_content" readonly></textarea><br/>

                </c:if>
                <c:if test="${not empty sessionScope.member}">
                    <textarea id="comment_content" name="comment_content" placeholder="여행의 즐거움이 담긴 후기를 남겨주세요." rows="4" cols="55"></textarea><br/>
                    <input id="comment_btn" type="submit" value="댓글작성" class="btn-register"/>
                    <hr class="comment-line"/>
                </c:if>
            </div>

            <div class="comment_action">
                <div>
                    <input type="hidden" name="post_idx" value="${vo.post_idx}">
                    <input type="hidden" name="cPage" value="${param.cPage}"/>
                    <input type="hidden" name="type" value="comment"/>
                    <input type="hidden" name="member_idx" value="${sessionScope.member.member_idx}"/>
                    <input type="hidden" name="member_nickname" value="${sessionScope.member.member_nickname}"/>

                </div>
            </div>
        </form>
        <!--무한스크롤-->
        <div id="dynamic_comment_list"></div>

        <p id="endOfList" style="display:none; text-align:center; color:gray;">더 이상 댓글이 없습니다.</p>


        <form name="ff" method="get">
            <input type="hidden" name="member_idx" value="${vo.getMember_idx()}">
            <input type="hidden" name="type"/>
            <input type="hidden" name="post_idx" value="${vo.getPost_idx()}"/>
            <input type="hidden" name="cPage" value="${param.cPage}"/>
        </form>

        <!-- 삭제시 보여주는 팝업창 -->
        <div id="del_dialog" title="삭제">
            <form action="Controller" method="post">
                <p>정말로 삭제 하시겠습니까?</p>
                <input type="hidden" name="type" value="del"/>
                <input type="hidden" name="post_idx" value="${vo.post_idx}"/>
                <input type="hidden" name="cPage" value="${param.cPage}"/>
                <input type="hidden" name="member_idx" value="${sessionScope.member.member_idx}"/>
                <button type="button" onclick="del(this.form)">삭제</button>
            </form>
        </div>

        <!--댓글신고-->
        <div id="warning_dialog" title="댓글 신고">
            <form id="CommentReportForm" action="Controller?type=reportComment" method="post">
                <p>신고 사유를 입력하세요:</p>
                <label>
                    <textarea name="reason" id="commentReport_reason" rows="5" style="width:95%; box-sizing:border-box;" required></textarea>
                </label>
                <input type="hidden" name="comment_idx" value=""/>
                <input type="hidden" name="post_idx" value="${vo.post_idx}"/>
                <input type="hidden" name="reporter_idx" value="${sessionScope.member.member_idx}"/>
                <input type="hidden" name="reported_idx" />

            </form>
        </div>
    </div>
</div>

<c:import url="/common/footer.jsp"/>

</body>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">

<script>
    document.addEventListener('DOMContentLoaded', function() {
        let allComments = [
            <c:forEach items="${comment_list}" var="c" varStatus="s">
            {
                comment_idx: "${c.comment_idx}",
                post_idx: "${c.post_idx}",
                member_idx: "${c.member_idx}",
                nickname: "${c.member_nickname}",
                content: "${fn:replace(c.comment_content, '&#10;', '<br/>')}",
                created_at: "${c.comment_created_at}",
                report_button_html: `<c:if test="${not empty sessionScope.member and sessionScope.member.member_idx != c.member_idx}">
                       <span class="report-emoji" title="신고하기" onclick="warningComment('${c.comment_idx}', '${c.member_idx}')">🚨</span>
                     </c:if>`
            }<c:if test="${!s.last}">,</c:if>
            </c:forEach>
        ];

        let container = document.getElementById('dynamic_comment_list');
        let start = 0;
        let limit  = 10;
        let isLoading = false;

        function renderComments() {
            if (start >= allComments.length || isLoading) {
                if (start >= allComments.length) {
                    document.getElementById("endOfList").style.display = "block";
                }
                return;
            }

            isLoading = true;

            for (let i = start; i < start + limit && i < allComments.length; i++) {
                const c = allComments[i];
                const nickname = c.nickname+" | " || "익명";
                const content = c.content || "";
                const creatAt = c.created_at.substring(0,10) || "";
                const div = document.createElement("div");
                const report_button_html = c.report_button_html;
                div.className = "comment-item";
                div.innerHTML =
                    '<div class="comment-header">' +
                    '<strong>' + nickname +creatAt+'</strong>' + report_button_html+
                    '</div>' +
                    '<div class="comment-body">' +
                    '<p>' + content + '</p>' +
                    '</div>' +
                    '<hr/>';
                container.appendChild(div);
            }

            start += limit;
            isLoading = false;

            if (start >= allComments.length) {
                document.getElementById("endOfList").style.display = "block";
                window.removeEventListener("scroll", handleScroll);
            }
        }

        function handleScroll() {
            if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 50 && !isLoading) {
                renderComments();
            }
        }

        renderComments();
        window.addEventListener("scroll", handleScroll);

    });

    $(function (){
        let option = {
            modal: true,
            autoOpen: false,
            resizable: false
        };

        $("#del_dialog").dialog(option);

        $("#report_dialog").dialog({
            autoOpen: false,
            modal: true,
            resizable: false,
            width: 400,
            buttons: {
                "신고하기": function () {
                    let reason = $("#report_reason").val().trim();
                    if (reason.length < 1) {
                        alert("신고 사유를 입력하세요.");
                        return;
                    }
                    $("#reportForm").submit();
                },
                "취소": function () {
                    $(this).dialog("close");
                }
            }
        });

        $("#loginDialog").dialog({
            autoOpen: false,
            modal: true,
            resizable: false
        });

        $("#warning_dialog").dialog({
            autoOpen: false,
            modal: true,
            resizable: false,
            width: 400,
            buttons: {
                "신고하기": function () {
                    let reason = $("#commentReport_reason").val().trim();
                    if (reason.length < 1) {
                        alert("신고 사유를 입력하세요");
                        return;
                    }
                    $("#CommentReportForm").submit();
                },
                "취소": function () {
                    $(this).dialog("close");
                }
            }
        });
        console.log("jQuery UI 다이얼로그 초기화 완료.");

    });

    function commentData() {
        let content = $("#comment_content").val();
        if (!content.trim()) {
            alert("내용을 입력하세요");
            return false;
        }
        return true;
    }

    let login = "${sessionScope.member != null}" === "true";

    function openReportDialog() {
        $("#report_reason").val("");
        $("#report_dialog").dialog("open");
    }

    function goList() {
        document.ff.action = "Controller";
        document.ff.type.value = "list";
        document.ff.submit();
    }

    function goDel() {
        $("#del_dialog").dialog("open");
    }
    function del(frm) {
        frm.submit();
    }

    function goEdit() {
        document.ff.action = "Controller";
        document.ff.type.value = "edit";
        document.ff.submit();
    }

    window.warningComment = function(comment_idx, reported_idx) {
        $("#commentReport_reason").val("");
        $("#CommentReportForm input[name='comment_idx']").val(comment_idx);
        $("#CommentReportForm input[name='reported_idx']").val(reported_idx);

        $("#warning_dialog").dialog("open");
        console.log("신고 다이얼로그 열기 - 댓글 인덱스:", comment_idx, "신고 대상자 인덱스:", reported_idx);
    }

    document.getElementById('heart').addEventListener('click', function() {
        const heart = document.getElementById('heart');
        const post_idx = document.getElementById('post_idx').value;
        const member_idx = document.getElementById('member_idx').value;

        if (!member_idx) {
            alert('로그인이 필요합니다.');
            return;
        }

        if (heart.classList.contains('fa-solid')) {
            alert('이미 추천한 게시글입니다.');
            return;
        }

        fetch("Controller?type=recommendInsert&member_idx=${sessionScope.member.member_idx}&post_idx=${requestScope.vo.post_idx}", {
            method: 'POST'
        })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    heart.classList.remove('fa-regular');
                    heart.classList.add('fa-solid');

                    const likesInput = document.getElementById('likesCount');
                    const display = document.getElementById('likesCountDisplay');
                    let likes = parseInt(likesInput.value);
                    likes++;
                    likesInput.value = likes;
                    display.textContent = likes;
                } else {
                    alert(data.message || '추천 처리 실패');
                }
            });
    })
</script>

</html>

