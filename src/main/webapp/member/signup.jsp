<%--
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
  <link rel="stylesheet" href="<c:url value="/css/header.css" />">
  <link rel="stylesheet" href="<c:url value="/css/footer.css" />">
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
<c:import url="/common/header.jsp" />

<form action="Controller?type=signup" method="post" name="SignUp_form">
  <table id="table">
    <caption>회원가입 테이블</caption>
    <tbody>
    <tr>
      <td>ID:</td>
      <td><input type="text" id="u_id" name="u_id"/><div id="id_usable"></div></td>
    </tr>
    <tr>
      <td>PW:</td>
      <td><input type="password" id="u_pw" name="u_pw"/><div id="pw_usable"></div> </td>
    </tr>
    <tr>
      <td>RE-PW:</td>
      <td><input type="password" id="u_repw" name="u_repw" /><div id="repw_usable"></div> </td>
    </tr>
    <tr>
      <td>별명:</td>
      <td><input type="text" id="u_nickname" name="u_nickname"/><div id="nickname_usable"></div></td>
    </tr>
    <tr>
      <td>이름:</td>
      <td><input type="text" id="u_name" name="u_name"/></td>
    </tr>
    <tr>
      <td>이메일:</td>
      <td>
        <input type="email" id="u_email" name="u_email"/>
        @
        <input type="email" id="u_email2" name="u_email2"/>
        <select id="emailAddr" name="emailAddr">
          <option id="no" value="">:::직접 입력:::</option>
          <option id="naver" value="naver.com">naver.com</option>
          <option id="gmail" value="gmail.com">gmail.com</option>
          <option id="daum" value="daum.net">daum.net</option>
          <option id="nate" value="nate.net">nate.net</option>
        </select>
        <button type="button" id="chkEmail">중복 검사</button>
        <div id="email_usable"></div></td>
    </tr>
    <tr>
      <td colspan="2"><button type="button" onclick="sendForm(this.form)">가입하기</button></td>
    </tr>
    </tbody>
  </table>
  <hr/>
</form>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</body>
<script>
  $(function (){
    //아이디 창에 타이핑을 쳤을 때
    $("#u_id").keyup(function (){
      let u_id = document.getElementById("u_id");
      let u_id_t = u_id.value.trim();
      if(u_id_t.length>0){
        $.ajax({
          url:"Controller?type=chkid",
          type:"post",
          data:"u_id="+u_id_t
        }).done(function (res) {
          $("#id_usable").html(res);
        });
      }else
        $("#id_usable").html("");
    });
    //비밀번호 창에 타이핑 했을 때
    $("#u_pw").keyup(function (){
      let u_pw = document.getElementById("u_pw");
      let u_pw_t = u_pw.value.trim();
      if (u_pw_t.length>0) {
        $.ajax({
          url: "Controller?type=chkpw",
          type: "post",
          data: "u_pw=" + u_pw_t
        }).done(function (res) {
          $("#pw_usable").html(res);
        });
      }else
        $("#pw_usable").html("");
    });

    $("#u_nickname").keyup(function (){
      let u_nickname = document.getElementById("u_nickname");
      let u_nickname_t = u_nickname.value.trim();
      if (u_nickname_t.length>0) {
        $.ajax({
          url: "Controller?type=chknickname",
          type: "post",
          data: "u_nickname=" + u_nickname_t
        }).done(function (res) {
          $("#nickname_usable").html(res);
        });
      }else
        $("#nickname_usable").html("");
    });

    //이메일 중복 검사 버튼을 눌렀을 때
    $("#chkEmail").click(function (){
      let u_email = document.getElementById("u_email");
      let u_email_t = u_email.value.trim();
      let emailAddr = document.getElementById("emailAddr").value;
      if(emailAddr.length==0){
        emailAddr = document.getElementById("u_email2").value;
      }

      if (u_email_t.length>0&&emailAddr.length>0) {
        $.ajax({
          url: "Controller?type=chkemail",
          type: "post",
          data:{u_email:u_email_t,emailAddr:emailAddr}
        }).done(function (res) {
          $("#email_usable").html(res);
        });
      }else
        $("#email_usable").html("");
    });

    // 이메일 중복 검사 후에 정보를 바꿨을 때 대비1
    $("#u_email").keyup(function (){
      $("#email_usable").html("<p>중복 검사 버튼을 눌러주세요</p><input type='hidden' id='disable'>")
    });
    // 이메일 중복 검사 후에 정보를 바꿨을 때 대비2
    $("#u_email2").keyup(function (){
      $("#email_usable").html("<p>중복 검사 버튼을 눌러주세요</p><input type='hidden' id='disable'>")
    });
    // 이메일 중복 검사 후에 정보를 바꿨을 때 대비3
    $("#emailAddr").blur(function (){
      $("#email_usable").html("<p>중복 검사 버튼을 눌러주세요</p><input type='hidden' id='disable'>")
    });

    // 비밀번호 확인(확인번호)에 타이핑을 쳤을 때
    $("#u_repw").keyup(function (){
      //비밀번호
      let u_pw = document.getElementById("u_pw");
      let u_pw_v = u_pw.value.trim();
      //확인번호
      let u_repw = document.getElementById("u_repw");
      let u_repw_v = u_repw.value.trim();

      if (u_pw_v!=u_repw_v){
        $("#repw_usable").html("비밀번호와 동일하게 입력해주세요.<input type='hidden' id='disable'>");
      }else{
        $("#repw_usable").text("");
      }
    });

    //이메일에서 주소를 선택했을 때
    $("#emailAddr").blur(function (){
      //비밀번호
      let emailAddr = document.getElementById("emailAddr");
      let emailAddr_v = emailAddr.value.trim();
      if(emailAddr_v.length>0) {
        document.getElementById("u_email2").value = "";
        document.getElementById("u_email2").disabled = true;
      }
    else
      document.getElementById("u_email2").disabled = false;
    });

  });

  function sendForm(frm) {
    //값 모두 받아오기
    let id = document.getElementById("u_id").value;
    let pw = document.getElementById("u_pw").value;
    let repw = document.getElementById("u_repw").value;
    let nickname = document.getElementById("u_nickname").value;
    let name = document.getElementById("u_name").value;
    let email1 = document.getElementById("u_email").value;
    let email2 = document.getElementById("u_email2").value;
    let email3 = document.getElementById("emailAddr").value;
    //유효성 검사
    if(id.length>0&&pw.length>0&&repw.length>0&&nickname.length>0&&name.length>0&&email1.length>0){
      let cmd =0;
      if(email3.length>0){
          cmd=1;
      }else {
        if(email2.length>0){
          cmd=1;
        }
      }

      if(cmd==1){
        if (document.getElementById("disable") == null) {
          document.SignUp_form.submit();
        } else {
          alert("입력 조건을 모두 확인해주세요")
        }
      }else
        alert("이메일을 확인해주세요")
    }else
      alert("모든 입력란에 입력을 확인해주세요")

    }
</script>
</html>--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>회원가입</title>
  <style>
    /* 전체 페이지 스타일 */
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      background-color: #f0f2f5;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    /* 회원가입 컨테이너 */
    .signup-container {
      width: 500px; /* 너비 확장 */
      padding: 40px;
      background-color: #ffffff;
      border-radius: 10px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
      text-align: center;
    }

    h2 {
      color: #004085;
      margin-bottom: 30px;
      font-size: 24px;
      font-weight: bold;
    }

    /* 폼 테이블 스타일 */
    .signup-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    .signup-table td {
      padding: 10px 0;
      text-align: left;
      vertical-align: top; /* 라벨이 위쪽에 정렬되도록 수정 */
    }

    .signup-table td:first-child {
      width: 100px; /* 라벨 컬럼 너비 조정 */
      color: #555;
      font-weight: bold;
      line-height: 40px; /* 입력 필드와 높이 맞추기 */
    }

    /* 입력 필드 그룹 */
    .input-group {
      display: flex;
      flex-direction: column; /* 세로 정렬 */
      width: 100%;
    }

    /* 입력 필드와 메시지 컨테이너 */
    .input-with-message {
      display: flex;
      align-items: center;
      gap: 10px;
      margin-bottom: 5px;
    }

    .input-field-full {
      flex: 1; /* 가득 채우기 */
    }

    /* 입력 필드 스타일 */
    .input-field {
      padding: 12px;
      border: 1px solid #ddd;
      border-radius: 5px;
      box-sizing: border-box;
      font-size: 14px;
      transition: border-color 0.3s;
      width: 100%; /* 너비를 100%로 설정 */
    }

    .input-field:focus {
      outline: none;
      border-color: #007bff;
    }

    /* 이메일 입력 필드 간 간격 */
    .email-group {
      display: flex;
      align-items: center;
      width: 100%;
      gap: 5px;
    }

    .email-group .input-field {
      width: 100px;
    }

    .email-separator {
      color: #888;
      font-weight: bold;
    }

    .email-select {
      flex-shrink: 0; /* 줄어들지 않게 */
      padding: 12px 8px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 14px;
      transition: border-color 0.3s;
    }

    /* 버튼 스타일 */
    .action-button {
      padding: 12px;
      border: none;
      border-radius: 5px;
      font-size: 14px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    #chkEmail {
      background-color: #6c757d;
      color: #ffffff;
    }

    #chkEmail:hover {
      background-color: #5a6268;
    }

    .signup-button {
      width: 100%;
      background-color: #007bff;
      color: #ffffff;
      font-size: 16px;
      font-weight: bold;
      margin-top: 20px;
    }

    .signup-button:hover {
      background-color: #0056b3;
    }

    /* 유효성 검사 메시지 스타일 */
    .validation-message {
      font-size: 12px;
      padding-left: 5px;
      white-space: nowrap; /* 메시지가 줄바꿈되지 않도록 설정 */
    }

    .validation-message.success {
      color: #28a745;
    }

    .validation-message.error {
      color: #dc3545;
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

<div class="signup-container">
  <h2>회원가입</h2>
  <form action="Controller?type=signup" method="post" name="SignUp_form">
    <table class="signup-table">
      <caption class="hidden">회원가입 테이블</caption>
      <tbody>
      <tr>
        <td>ID:</td>
        <td>
          <div class="input-group">
            <div class="input-with-message">
              <input type="text" id="u_id" name="u_id" class="input-field input-field-full" placeholder="아이디"/>
              <div id="id_usable" class="validation-message"></div>
            </div>
          </div>
        </td>
      </tr>
      <tr>
        <td>PW:</td>
        <td>
          <div class="input-group">
            <div class="input-with-message">
              <input type="password" id="u_pw" name="u_pw" class="input-field input-field-full" placeholder="비밀번호"/>
              <div id="pw_usable" class="validation-message"></div>
            </div>
          </div>
        </td>
      </tr>
      <tr>
        <td>RE-PW:</td>
        <td>
          <div class="input-group">
            <div class="input-with-message">
              <input type="password" id="u_repw" name="u_repw" class="input-field input-field-full" placeholder="비밀번호 확인"/>
              <div id="repw_usable" class="validation-message"></div>
            </div>
          </div>
        </td>
      </tr>
      <tr>
        <td>별명:</td>
        <td>
          <div class="input-group">
            <div class="input-with-message">
              <input type="text" id="u_nickname" name="u_nickname" class="input-field input-field-full" placeholder="별명"/>
              <div id="nickname_usable" class="validation-message"></div>
            </div>
          </div>
        </td>
      </tr>
      <tr>
        <td>이름:</td>
        <td>
          <input type="text" id="u_name" name="u_name" class="input-field" placeholder="이름"/>
        </td>
      </tr>
      <tr>
        <td>이메일:</td>
        <td>
          <div class="input-group">
            <div class="email-group">
              <input type="email" id="u_email" name="u_email" class="input-field" placeholder="이메일"/>
              <span class="email-separator">@</span>
              <input type="email" id="u_email2" name="u_email2" class="input-field" placeholder="직접 입력" disabled/>
              <select id="emailAddr" name="emailAddr" class="email-select">
                <option value="">직접 입력</option>
                <option value="naver.com">naver.com</option>
                <option value="gmail.com">gmail.com</option>
                <option value="daum.net">daum.net</option>
                <option value="nate.net">nate.net</option>
              </select>
            </div>
            <div style="display: flex; align-items: center; margin-top: 5px;">
              <button type="button" id="chkEmail" class="action-button">중복 검사</button>
              <div id="email_usable" class="validation-message" style="margin-left: 10px;"></div>
            </div>
          </div>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <button type="button" onclick="sendForm(this.form)" class="action-button signup-button">가입하기</button>
        </td>
      </tr>
      </tbody>
    </table>
  </form>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
  $(function (){
    // 아이디, 비밀번호, 별명, 이메일 중복 검사 결과 메시지를 예쁘게 표시하기 위한 함수
    function updateValidationMessage(targetId, res) {
      const $target = $(targetId);
      $target.removeClass('success error');
      if (res.includes("가능")) {
        $target.addClass('success').html(res);
      } else if (res.length > 0) {
        $target.addClass('error').html(res + "<input type='hidden' class='disable_check'>");
      } else {
        $target.html('');
      }
    }

    // 아이디 창에 타이핑을 쳤을 때
    $("#u_id").keyup(function (){
      const u_id_t = $(this).val().trim();
      if(u_id_t.length > 0){
        $.ajax({
          url:"Controller?type=chkid",
          type:"post",
          data:{ u_id: u_id_t }
        }).done(function (res) {
          updateValidationMessage("#id_usable", res);
        });
      } else {
        $("#id_usable").html("");
      }
    });

    // 비밀번호 창에 타이핑 했을 때
    $("#u_pw").keyup(function (){
      const u_pw_t = $(this).val().trim();
      if (u_pw_t.length > 0) {
        $.ajax({
          url: "Controller?type=chkpw",
          type: "post",
          data:{ u_pw: u_pw_t }
        }).done(function (res) {
          updateValidationMessage("#pw_usable", res);
        });
      } else {
        $("#pw_usable").html("");
      }
      // 비밀번호 확인 필드도 같이 검사
      $("#u_repw").trigger('keyup');
    });

    // 별명 창에 타이핑을 쳤을 때
    $("#u_nickname").keyup(function (){
      const u_nickname_t = $(this).val().trim();
      if (u_nickname_t.length > 0) {
        $.ajax({
          url: "Controller?type=chknickname",
          type: "post",
          data:{ u_nickname: u_nickname_t }
        }).done(function (res) {
          updateValidationMessage("#nickname_usable", res);
        });
      } else {
        $("#nickname_usable").html("");
      }
    });

    // 이메일 주소 선택했을 때
    $("#emailAddr").change(function (){
      const emailAddr_v = $(this).val().trim();
      const $u_email2 = $("#u_email2");
      if(emailAddr_v.length > 0) {
        $u_email2.val("");
        $u_email2.prop('disabled', true);
      } else {
        $u_email2.prop('disabled', false);
      }
      // 이메일 정보 변경 시 중복 검사 메시지 초기화
      $("#email_usable").html("<span class='error'>중복 검사 버튼을 눌러주세요</span><input type='hidden' class='disable_check'>");
    });

    // 이메일 중복 검사 버튼을 눌렀을 때
    $("#chkEmail").click(function (){
      const u_email_t = $("#u_email").val().trim();
      let emailAddr = $("#emailAddr").val();

      if(emailAddr.length == 0){
        emailAddr = $("#u_email2").val().trim();
      }

      if (u_email_t.length > 0 && emailAddr.length > 0) {
        $.ajax({
          url: "Controller?type=chkemail",
          type: "post",
          data:{ u_email: u_email_t, emailAddr: emailAddr }
        }).done(function (res) {
          updateValidationMessage("#email_usable", res);
        });
      } else {
        $("#email_usable").html("<span class='error'>이메일을 모두 입력해주세요</span><input type='hidden' class='disable_check'>");
      }
    });

    // 이메일 중복 검사 후에 정보를 바꿨을 때 대비
    $("#u_email, #u_email2").keyup(function (){
      $("#email_usable").html("<span class='error'>중복 검사 버튼을 눌러주세요</span><input type='hidden' class='disable_check'>");
    });

    // 비밀번호 확인(확인번호)에 타이핑을 쳤을 때
    $("#u_repw").keyup(function (){
      const u_pw_v = $("#u_pw").val().trim();
      const u_repw_v = $(this).val().trim();

      const $repw_usable = $("#repw_usable");
      $repw_usable.removeClass('success error');

      if (u_pw_v.length > 0 && u_repw_v.length > 0) {
        if (u_pw_v === u_repw_v) {
          $repw_usable.addClass('success').text("비밀번호가 일치합니다.");
        } else {
          $repw_usable.addClass('error').html("비밀번호와 동일하게 입력해주세요.<input type='hidden' class='disable_check'>");
        }
      } else {
        $repw_usable.html("");
      }
    });

  });

  function sendForm(frm) {
    // 값 모두 받아오기
    const id = $("#u_id").val().trim();
    const pw = $("#u_pw").val().trim();
    const repw = $("#u_repw").val().trim();
    const nickname = $("#u_nickname").val().trim();
    const name = $("#u_name").val().trim();
    const email1 = $("#u_email").val().trim();
    const email2 = $("#u_email2").val().trim();
    const email3 = $("#emailAddr").val().trim();

    // 유효성 검사
    if (id.length === 0 || pw.length === 0 || repw.length === 0 || nickname.length === 0 || name.length === 0 || email1.length === 0) {
      alert("모든 필수 입력란에 입력을 확인해주세요.");
      return;
    }

    if (email3.length === 0 && email2.length === 0) {
      alert("이메일 주소를 입력하거나 선택해주세요.");
      return;
    }

    // 유효성 검사 통과 여부 확인
    if ($(".disable_check").length > 0) {
      alert("입력 조건을 모두 확인해주세요.");
    } else {
      document.SignUp_form.submit();
    }
  }
</script>
</body>
</html>
