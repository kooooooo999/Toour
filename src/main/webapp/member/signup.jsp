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
</html>