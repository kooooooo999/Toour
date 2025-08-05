<%--
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
  <style>
    #table{
      border-collapse: collapse;
    }
    #table caption{
      text-indent: -9999px;
      height: 0;
    }
    #table td{
      border: 1px solid #000;
    }
  </style>
</head>
<body>
<form action="Controller?type=login" method="post" name="login_form">
  <table id="table">
    <caption>회원가입 테이블</caption>
    <tbody>
    <tr>
      <td>ID:</td>
      <td><input type="text" id="u_id" name="u_id" value="${param.u_id}"/></td>
    </tr>
    <tr>
      <td>PW:</td>
      <td><input type="password" id="u_pw" name="u_pw" value="${param.u_pw}"/></td>
    </tr>
    <tr>
      <td colspan="2"><button type="button" onclick="sendForm(this.form)">로그인</button></td>
    </tr>
    </tbody>
  </table>
  <hr/>
</form>
<script>
  function sendForm(frm) {
    let u_id = document.getElementById("u_id");
    let u_id_t = u_id.value.trim();
    let u_pw = document.getElementById("u_pw");
    let u_pw_t = u_pw.value.trim();

    if(u_id_t.length>0&&u_pw_t.length)
      document.login_form.submit();
    else
      alert("모든 입력란에 입력을 완수해주세요")
  }
</script>
</body>
</html>--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <style>
    /* 전체 페이지 스타일 */
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      background-color: #f0f2f5; /* 메인 화면 배경과 어울리는 약간 푸른 회색 계열 */
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    /* 로그인 컨테이너 */
    .login-container {
      width: 350px;
      padding: 40px;
      background-color: #ffffff;
      border-radius: 10px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    h2 {
      color: #004085; /* 메인 화면 로고의 푸른색과 유사 */
      margin-bottom: 30px;
      font-size: 24px;
      font-weight: bold;
    }

    /* 폼 테이블 스타일 */
    .login-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    .login-table td {
      padding: 10px 0;
      text-align: left;
    }

    .login-table td:first-child {
      width: 60px;
      color: #555;
    }

    /* 입력 필드 스타일 */
    .input-field {
      width: 100%;
      padding: 12px;
      border: 1px solid #ddd;
      border-radius: 5px;
      box-sizing: border-box;
      font-size: 14px;
      transition: border-color 0.3s;
    }

    .input-field:focus {
      outline: none;
      border-color: #007bff;
    }

    /* 로그인 버튼 스타일 */
    .login-button-container {
      padding-top: 20px;
    }

    .login-button {
      width: 100%;
      padding: 12px;
      border: none;
      border-radius: 5px;
      background-color: #007bff; /* 메인 화면의 푸른색과 어울리는 색상 */
      color: #ffffff;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .login-button:hover {
      background-color: #0056b3;
    }

    /* hidden caption */
    .hidden {
      position: absolute;
      width: 1px;
      height: 1px;
      margin: -1px;
      padding: 0;
      overflow: hidden;
      clip: rect(0, 0, 0, 0);
      border: 0;
    }
  </style>
</head>
<body>

<div class="login-container">
  <h2>로그인</h2>
  <form action="Controller?type=login" method="post" name="login_form">
    <table class="login-table">
      <caption class="hidden">로그인 테이블</caption>
      <tbody>
      <tr>
        <td>ID:</td>
        <td><input type="text" id="u_id" name="u_id" value="${param.u_id}" class="input-field" placeholder="아이디"/></td>
      </tr>
      <tr>
        <td>PW:</td>
        <td><input type="password" id="u_pw" name="u_pw" value="${param.u_pw}" class="input-field" placeholder="비밀번호"/></td>
      </tr>
      </tbody>
    </table>
    <div class="login-button-container">
      <button type="button" class="login-button" onclick="sendForm(this.form)">로그인</button>
    </div>
  </form>
</div>

<script>
  function sendForm(frm) {
    let u_id = document.getElementById("u_id").value.trim();
    let u_pw = document.getElementById("u_pw").value.trim();

    if (u_id.length > 0 && u_pw.length > 0) {
      document.login_form.submit();
    } else {
      alert("모든 입력란에 입력을 완수해주세요.");
    }
  }
</script>

</body>
</html>