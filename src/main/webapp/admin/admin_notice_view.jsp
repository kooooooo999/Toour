<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>관리자 페이지</title>
  <style>
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      display: flex;
      background-color: #f4f6f8;
    }

    .sidebar {
      width: 220px;
      background-color: #2c3e50;
      display: flex;
      flex-direction: column;
      padding: 20px;
      color: white;
      height: 100vh;
    }

    .sidebar a {
      text-decoration: none;
      color: white;
      padding: 12px 10px;
      border-bottom: 1px solid #34495e;
      transition: background-color 0.3s;
    }

    .sidebar a:hover {
      background-color: #34495e;
    }

    .main-content {
      flex: 1;
      padding: 40px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      border-radius: 6px;
      overflow: hidden;
    }

  </style>
</head>
<body>

<div class="sidebar">

  <!-- 메뉴 -->
  <a href="AdminController">🏠 HOME</a>
  <a href="AdminController?type=adminnotice">📢 공지사항 관리</a>
  <a href="product_list.jsp?category=sp003">📝 게시물 관리</a>
  <a href="product_list.jsp?category=sp003">🍽 관광지/맛집 관리</a>
  <a href="product_list.jsp?category=sp003">🗺 관광코스 관리</a>
  <a href="AdminController?type=adminmemlist">👥 회원정보 관리</a>
</div>

<div class="main-content">
  <h1>관리자 페이지</h1>
</div>

<c:set var="vo" value="${requestScope.vo}"/>

<div id="post">
  <form method="post" >
    <table>
      <tbody>
      <tr>
        <th>제목:</th>
        <td>${vo.post_title}</td>
      </tr>

      <tr>
        <th>첨부파일:</th>
        <td><a href="#">
          ${vo.file_name_original}
        </a></td>
      </tr>

      <tr>
        <th>이름:</th>
        <td>${vo.member_idx}</td>
      </tr>
      <tr>
        <th>내용:</th>
        <td>${vo.post_content}</td>
      </tr>

      <tr>
        <td colspan="2">
          <input type="button" value="수정" onclick="goEdit()"/>
          <input type="button" value="삭제" onclick="goDel()"/>
          <%--<input type="button" value="목록" onclick="javascript:location.href='Controller?type=list&cPage=${param.cPage}'"/>--%>
          <input type="button" value="목록" onclick="goList()"/>
        </td>
      </tr>
      </tbody>
    </table>
  </form>

  <form name="ff" method="post">
    <input type="hidden" name="type"/>
    <input type="hidden" name="post_idx" value="${vo.getPost_idx()}"/>
    <input type="hidden" name="cPage" value="${param.cPage}"/>
  </form>

  <!-- 삭제시 보여주는 팝업창 -->
  <div id="del_dialog" title="삭제">
    <form action="Controller" method="post">
      <%--비밀번호 표현등 할 수 있음 --%>
      <p>정말로 삭제 하시겠습니까?</p>
      <input type="hidden" name="type" value="del"/>
      <input type="hidden" name="post" value="${vo.getPost_idx()}"/>
      <input type="hidden" name="cPage" value="${param.cPage}"/>
      <button type="button" onclick="del(this.form)">삭제</button>
    </form>
  </div>

</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
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

  function goList() {
    document.ff.action = "AdminController";
    document.ff.type.value = "adminnotice"
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
    document.ff.action = "Controller";
    document.ff.type.value = "edit";
    document.ff.submit();
  }
</script>

</body>
</html>
