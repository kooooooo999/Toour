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


  </style>

</head>
<body>
<c:import url="/common/header.jsp" />
<c:set value="${sessionScope.member}" var="user"/>
<c:set var="vo" value="${requestScope.vo}"/>
<c:set var="member_info" value="${requestScope.member_info}"/>


<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
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
      </div>
      </c:if>
        <div class="comment_action">
          <div>
            <input type="hidden" name="post_idx" value="${vo.getPost_idx()}">
            <input type="hidden" name="cPage" value="${param.cPage}"/>
            <input type="hidden" name="type" value="comment"/>
            <input type="hidden" name="member_idx" value="${sessionScope.member.member_idx}"/>
            <input type="hidden" name="member_nickname" value="${sessionScope.member.member_nickname}"/>

                </div>
            </div>
        </form>


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
      <input type="hidden" name="post_idx" value="${vo.getPost_idx()}"/>
      <input type="hidden" name="cPage" value="${param.cPage}"/>
      <input type="hidden" name="member_idx" value="${sessionScope.member.member_idx}"/>
      <button type="button" onclick="del(this.form)">삭제</button>
    </form>
  </div>


        <%--  댓글들<hr/>--%>

        <c:if test="${not empty requestScope.comment_list}">
        <div class="comment_list">
            <!-- 댓글이 위에서 아래로 출력됨 -->
            <c:forEach items="${requestScope.comment_list}" varStatus="vs" var="cvo">
                <div id="comment_list">
                    <div id="comment_nickname">
                            ${cvo.member_nickname} &nbsp;
                        | &nbsp;${cvo.comment_updated_at}
                        &nbsp;&nbsp; <c:if test="${sessionScope.member.member_idx != member_info.member_idx}">
                                <c:set var="comment_idx" value="${cvo.comment_idx}"/>
                                <span class="report-emoji" title="신고하기"
                                      onclick="warningComment(${cvo.comment_idx})">🚨</span>
                            </c:if>
                    </div>
                    <div id="comment_post">
                            ${cvo.comment_content}
                    </div>
                </div>
                <hr/>
            </c:forEach>
        </c:if>
            <!--댓글신고-->
            <div id="warning_dialog" title="신고">
                <form id="CommentReportForm" action="Controller?type=reportComment" method="post">
                    <p>신고 사유를 입력하세요:</p>
                    <label><textarea name="reason" id="commentReport_reason" rows="5" style="width:95%; box-sizing:border-box;" required></textarea></label>
                    <input type="hidden" name="post_idx" value="${vo.post_idx}"/>
                    <input type="hidden" name="comment_idx" value=""/>
                    <input type="hidden" name="reporter_idx" value="${sessionScope.member.member_idx}"/>
                    <input type="hidden" name="reported_idx" value="${member_info.member_idx}"/>
                    <button type="button" onclick="warning(this.form)">신고</button>
                </form>
            </div>

        </div>
    </div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">

<script>
  // 로그인 여부 체크
  let login = ${sessionScope.memeber != null};

  $(function (){
    let option = {
      modal: true,
      autoOpen: false, // 호출되는 즉시 대화상자 표시(기본값: true)
      resizable: false,
    };

    // 삭제 다이얼로그 초기화
    $("#del_dialog").dialog(option);
  });

  // 신고 다이얼로그 초기화
  $(function goReport() {
    $("#report_dialog").dialog({
      autoOpen: false, // 처음에는 닫혀있음
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
  });

  // 신고 다이얼로그 열기 함수
  function openReportDialog() {
    $("#report_reason").val(""); // 이전 입력값 초기화
    $("#report_dialog").dialog("open");
  }

  // 댓글
  function commentData() {
      let title = $("#comment_content").val();
      if (title.trim().length < 1) {
          alert("내용을 입력하세요");
          $("#comment_content").val("");
          $("#comment_content").focus();
          return false;
      }

      return true;
  }

  function goList() {
    document.ff.action = "Controller";
    document.ff.type.value = "list";
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

      //댓글 신고 다이얼 로그 열기 함수

      function warningComment(comment_idx) {
          $("#commentReport_reason").val("");
          $("#CommentReportForm input[name='comment_idx']").val(comment_idx);
          $("#warning_dialog").dialog("open");
          console.log(comment_idx);
      }


        $(function () {
            $("#loginDialog").dialog({
                autoOpen: false,
                modal: true,
                resizable: false
            });
            // $("#loginDialog").dialog(option);
        });

        $(function sendReport() {
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
        });

    </script>
</div>
<c:import url="/common/footer.jsp"/>
</body>

</html>













