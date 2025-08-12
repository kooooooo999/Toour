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

    /* 댓글 버튼 영역 */
    .post-buttons {
      display: flex;
      gap: 10px;
      justify-content: flex-end;
      margin-right: 20px;
    }

    .btn-pho {
      padding: 7px 16px;
      border: 1px solid #ccc;
      background-color: #fff;
      color: #333;
      font-size: 14px;
      border-radius: 6px;
      cursor: pointer;
    }

    .btn-register {
      padding: 8px 20px;
      background-color: #222;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-size: 14px;
      transition: background-color 0.2s;
    }

    .btn-register:hover {
      background-color: #444;
    }

    /* 댓글 리스트 영역 */
    .comment_list {
      display: inline-block;
      width: 60%; /* 나머지 60% */
      max-height: 300px;
      overflow-y: auto;
      border: 1px solid #ddd;
      border-radius: 6px;
      padding: 10px 20px;
      font-size: 14px;
      line-height: 1.5;
      color: #333;
      background: #fafafa;
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



  </style>

</head>
<body>
<c:import url="/common/header.jsp" />
<c:set value="${sessionScope.user}" var="user"/>
<c:set var="vo" value="${requestScope.vo}"/>
<c:set var="member_info" value="${requestScope.member_info}"/>



<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<div id="post">
  <form method="post" >
    <table summary="게시판 글쓰기" class="post-table">
      <caption>게시판 글쓰기</caption>
      <tbody>
      <tr class="post-title">
        <th>제목:</th>
        <td colspan="3">${vo.post_title}</td>
      </tr>

      <!--게시물-->
      <tr class="post-name">
        <th>별명:</th>
        <td>${member_info.member_nickname}</td>
        <th>작성일</th>
        <td>${vo.post_updated_at}</td>
      </tr>
      <tr class="post-content">
        <th>내용:</th>
       <td colspan="3">${vo.post_content}</td>
      </tr>
      </tbody>

      <tr>
        <th>첨부파일:</th>
        <td colspan="3">
          <c:if test="${not empty requestScope.fileList}">
            <c:forEach var="file" items="${requestScope.fileList}">

              <div>
                <a href="<c:url value="/bbs_upload/${file.file_name_stored}"/>">${file.file_name_original}</a>
              </div>
            </c:forEach>
          </c:if>
          <%-- Display message if the list of files is empty --%>
          <c:if test="${empty requestScope.fileList}">
            첨부파일 없음
          </c:if>
        </td>
      </tr>

    </table>
  </form>

      <div class="post-buttons">
        <c:if test="${not empty sessionScope.user}">
          <c:if test="${sessionScope.user.member_idx==member_info.member_idx}">
            <input type="button" value="수정" onclick="goEdit()"/>
            <input type="button" value="삭제" onclick="goDel()"/>
          </c:if>
        </c:if>
        <input type="button" value="목록" onclick="goList()"/>
      </div>

  <!--댓글 작성-->
  <div id="comment_form">
    <h3>댓글</h3>
    <form  encType="multipart/form-data" action="Controller?type=comment" method="post" name="comment_form"
           onsubmit="return commentData()">
      <div class="comment_container">
        <textarea id="comment_content" placeholder="여행의 즐거움이 담긴 후기를 남겨주세요." rows="4" cols="55" name="post_content"></textarea><br/>
      </div>
        <div class="comment_action">
          <div>
            <label for="fileUp" class="btn-pho">
              <span class="icon">📷</span> 사진
            </label>

            <input type="file" id="fileUp" name="fileUp" onchange="fileChange(this,true)" style="display:none;">

            <input type="hidden" name="post_idx" value="${vo.getPost_idx()}">
            <input type="hidden" name="cPage" value="${param.cPage}"/>
            <input type="hidden" name="type" value="comment"/>
            <input type="hidden" name="member_idx" value="${sessionScope.user.member_idx}"/>
            <input type="hidden" name="member_nickname" value="${sessionScope.user.member_nickname}"/>

            <%--      <c:if test="${not empty sessionScope.user}">--%>
            <input type="submit" value="댓글" class="btn-register"/>

            <div id="loginDialog" title="로그인" style="display: none">
              <%--      </c:if>--%>
              <%--      <c:if test="${empty sessionScope.user}">--%>
              <h3>댓글 작성을 하려면 로그인이 필요합니다.</h3>
              <p>
                <a href="Controller?type=moveLogin">로그인</a>
                또는
                <a href="Controller?type=moveSignup">회원가입</a>을 해주세요.
              </p>
              <%--      </c:if>--%>
            </div>
          </div>
        </div>
    </form>


  <form name="ff" method="get">
    <input type="hidden" name="type" />
    <input type="hidden" name="post_idx" value="${vo.getPost_idx()}"/>
    <input type="hidden" name="cPage" value="${param.cPage}"/>
  </form>

  <!-- 삭제시 보여주는 팝업창 -->
  <div id="del_dialog" title="삭제">
    <form action="Controller" method="post">
      <p>정말로 삭제 하시겠습니까?</p>
      <input type="hidden" name="type" value="del"/>
      <input type="hidden" name="post" value="${vo.getPost_idx()}"/>
      <input type="hidden" name="cPage" value="${param.cPage}"/>
      <button type="button" onclick="del(this.form)">삭제</button>
    </form>
  </div>

<%--  댓글들<hr/>--%>
<div class="comment_list">
  <c:forEach items="${requestScope.comment_list}" varStatus="vs" var="cvo">

    <div>
      별명 :${cvo.member_nickname} &nbsp;
      | ${cvo.comment_updated_at}<br/>
      내용:${cvo.comment_content}
    </div>
    <hr/>

  </c:forEach>
</div>
</div>

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

  let login = ${sessionScope.user != null};

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













