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

    .hide{ display: none; }
  </style>

</head>
<body>
<c:import url="/common/header.jsp" />
<c:set value="${sessionScope.user}" var="user"/>
<c:set var="vo" value="${requestScope.vo}"/>
<c:set var="member_info" value="${requestScope.member_info}"/>


<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<script>
  $(function (){
    let option = {
      modal: true,
      autoOpen: false, // 호출되는 즉시 대화상자 표시(기본값: true)
      resizable: false,
    };

    $("#del_dialog").dialog(option);
  });

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
</script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<div id="post">
  <form method="post" >
    <table summary="게시판 글쓰기">
      <caption>게시판 글쓰기</caption>
      <tbody>
      <tr>
        <th>제목:</th>
        <td>${vo.post_title}</td>
      </tr>

      <tr>
        <th>첨부파일:</th>
        <td>
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

      <tr>
        <th>이름:</th>
        <td>${member_info.member_nickname}</td>
      </tr>
      <tr>
        <th>내용:</th>
        <td>${vo.post_content}</td>
      </tr>
      <tr>
        <td colspan="2">
          <c:if test="${not empty sessionScope.user}">
            <c:if test="${sessionScope.user.member_idx==member_info.member_idx}">
              <input type="button" value="수정" onclick="goEdit()"/>
              <input type="button" value="삭제" onclick="goDel()"/>
            </c:if>
          </c:if>
          <input type="button" value="목록" onclick="goList()"/>
        </td>
      </tr>
      </tbody>
    </table>
  </form>

  <!--댓글 작성-->
  <div id="comment_form">
    <form  encType="multipart/form-data" action="Controller?type=comment" method="post" name="comment_form"
           onsubmit="return commentData()">

      <label>이름:<span>${sessionScope.user.member_nickname}</span><br/></label>
      <label>내용:<textarea rows="4" cols="55" name="comment_content" id="comment_content"></textarea><br/></label>

      <input type="hidden" name="post_idx" value="${vo.getPost_idx()}">
      <input type="hidden" name="cPage" value="${param.cPage}"/>
      <input type="hidden" name="type" value="comment"/>
      <input type="hidden" name="member_idx" value="${sessionScope.user.member_idx}"/>
      <input type="hidden" name="member_nickname" value="${sessionScope.user.member_nickname}"/>
      <c:if test="${not empty sessionScope.user}">
        <input type="submit" value="댓글작성"/>
      </c:if>
      <c:if test="${empty sessionScope.user}">
        <h3>로그인이 필요합니다.</h3>
        <p>
          <a href="Controller?type=moveLogin">로그인</a>
          또는
          <a href="Controller?type=moveSignup">회원가입</a>을 해주세요.
        </p>
      </c:if>

    </form>
  </div>

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

  </br>
  댓글들<hr/>
  <c:forEach items="${requestScope.comment_list}" varStatus="vs" var="cvo">

    <div>
      별명 :${cvo.member_nickname} &nbsp;&nbsp;
      최종수정:${cvo.comment_updated_at}<br/>
      내용:${cvo.comment_content}
    </div>
    <hr/>

  </c:forEach>





</div>


</body>

<c:import url="/common/footer.jsp" />

</html>













