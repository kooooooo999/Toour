<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
  <meta charset="UTF-8">
  <style>
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      display: flex;
      background-color: #f4f6f8;
      color: #333;
      overflow-x: hidden; /* 가로 넘침 숨김 */
    }

    .sidebar {
      width: 220px;
      background-color: #2c3e50;
      display: flex;
      flex-direction: column;
      padding: 20px;
      color: white;
      height: 100vh;
      box-sizing: border-box;
      flex-shrink: 0;
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

    /* 세로 텍스트 스타일 추가 */
    .vertical-text {
      writing-mode: vertical-rl;
      text-orientation: mixed;
      width: 30px;          /* 폭 고정 */
      padding: 10px 5px;
      margin-left: 10px;    /* 사이드바와 간격 */
      background-color: white;
      color: #2c3e50;
      font-weight: 700;
      font-size: 18px;
      user-select: none;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 6px;
      flex-shrink: 0;
    }

    .main-content {
      flex: 1;
      padding: 40px;
      background-color: white;
      border-radius: 8px;
      margin: 20px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      box-sizing: border-box;
      max-width: calc(100vw - 260px); /* 사이드바(220) + 세로텍스트(30) + margin(10) 빼기 */
      overflow-wrap: break-word;
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      border-radius: 6px;
      overflow: hidden;
      box-shadow: 0 0 8px rgba(0,0,0,0.1);
      table-layout: fixed; /* 너비 고정 */
      word-break: break-word; /* 긴 내용 줄바꿈 */
    }

    th, td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #ddd;
      vertical-align: top;
    }

    th {
      background-color: #2c3e50;
      color: white;
      width: 120px;
      font-weight: 600;
    }

    td a {
      color: #2980b9;
      text-decoration: none;
    }

    td a:hover {
      text-decoration: underline;
    }

    input[type="button"] {
      background-color: #2980b9;
      border: none;
      color: white;
      padding: 8px 18px;
      margin-right: 10px;
      border-radius: 4px;
      cursor: pointer;
      font-weight: 600;
      transition: background-color 0.3s ease;
    }

    input[type="button"]:hover {
      background-color: #1f6391;
    }

    /* 삭제 팝업 스타일 */
    #del_dialog {
      font-size: 14px;
    }
    #del_dialog p {
      margin-bottom: 20px;
    }
    #del_dialog button {
      background-color: #e74c3c;
      border: none;
      color: white;
      padding: 6px 15px;
      border-radius: 4px;
      cursor: pointer;
      font-weight: 600;
      transition: background-color 0.3s ease;
    }
    #del_dialog button:hover {
      background-color: #c0392b;
    }
  </style>
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

<!-- 세로 텍스트 영역 -->
<div class="vertical-text">관리자페이지</div>

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
        <td>관리자</td>
      </tr>
      <tr>
        <th>내용:</th>
        <td>${vo.post_content}</td>
      </tr>

      <tr>
        <td colspan="2">
          <input type="button" value="수정" onclick="goEdit()"/>
          <input type="button" value="삭제" onclick="openDel()"/>
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
      <button type="button" onclick="goDel()">삭제</button>
    </form>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

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
    document.ff.type.value = "adminnotice";
    document.ff.submit();
  }
  function openDel() {
    $("#del_dialog").dialog("open");
  }

  function goDel() {
    document.ff.action = "AdminController";
    document.ff.type.value = "adminnoticedel";
    document.ff.submit();
  }

  function goEdit() {
    document.ff.action = "AdminController";
    document.ff.type.value = "adminnoticeedit";
    document.ff.submit();
  }
</script>

</body>
</html>
