<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %><%--
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
<c:import url="/common/footer.jsp" />

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
      margin-bottom: 10px;
    }

    .kakao_login_btn {
      display: block;
      margin-bottom: 6px; /* 카카오와 네이버 버튼 사이 */
    }

    .naver_login_btn {
      height: 47px;
      display: block;
    }

    .login-button {
      /*width: 100%;*/
      width: 190px;
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
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.5/kakao.min.js" integrity="sha384-dok87au0gKqJdxs7msEdBPNnKSRT+/mhTVzq+qOhcL464zXwvcrpjeWvyj1kCdq6" crossorigin="anonymous"></script>

<body>

<div class="login-container">
  <h2 >로그인</h2>
  <form action="Controller?type=login" method="post" name="login_form">
    <table class="login-table">
      <caption class="hidden">로그인 테이블</caption>
      <tbody>
      <tr>
        <td>ID:</td>
        <td><input type="text" id="u_id" name="u_id" value="${param.u_id}" class="input-field" placeholder="아이디" onkeydown="if(event.key=='Enter') sendForm(this.form)"/></td>
      </tr>
      <tr>
        <td>PW:</td>
        <td><input type="password" id="u_pw" name="u_pw" value="${param.u_pw}" class="input-field" placeholder="비밀번호"  onkeydown="if(event.key=='Enter') sendForm(this.form)"/></td>
      </tr>
      </tbody>
    </table>
  <%-- 로그인 버튼 --%>
    <div class="login-button-container">
      <button type="button" class="login-button" onclick="sendForm(this.form)">로그인</button>
    </div>
  </form>
  <!-- 카카오 로그인 -->
  <div class="social">
    <a class="kakao_login_btn" id="kakao_login_btn" href="javascript:loginWithKakao()">
      <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
           width="190" height="48" alt="카카오 로그인 버튼"/>
    </a>
  </div>
  <!-- 네이버 로그인 버튼 -->
  <%
    String clientId = "02aFSrv2E53MWqQAERSx";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8080/member/callback.jsp", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
            + "&client_id=" + clientId
            + "&redirect_uri=" + redirectURI
            + "&state=" + state;
    session.setAttribute("state", state);
//    System.out.println(apiURL);
  %>
  <a class="naver_login_btn" id="naver_id_login" href="<%=apiURL%>">
    <img src="<c:url value='/images/naver_btn.png' />" width="190" height="48" alt="네이버 로그인 버튼" />
  </a>

  <p id="token-result"></p>
</div>


<%--
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
--%>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<div id="naver_id_login"></div>

<!-- 네이버 로그인 초기화 Script -->
<script type="text/javascript"><!--naver_id_login : client-id-->
  var naver_id_login = new naver_id_login("02aFSrv2E53MWqQAERSx", "http://localhost:8080/member/callback.jsp");
  var state = naver_id_login.getUniqState(); // 토큰 담을곳
  naver_id_login.setState(state);
  naver_id_login.setPopup(); // 팝업창
  // naver_id_login.setDomain(""); // 서비스 UI
  naver_id_login.setButton("green", 3,40); // 로그인 버튼 디자인
  naver_id_login.init_naver_id_login(); // 로그인 버튼 새로 그리기
</script>


<!-- 네이버 로그인 Callback페이지 처리 Script -->
<script type="text/javascript">
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
    // naver_id_login.getProfileData('프로필 항목명');
    // 프로필 항목은 개발가이드를 참고하시기 바랍니다.
    alert(naver_id_login.getProfileData('email'));
    alert(naver_id_login.getProfileData('nickname'));
    alert(naver_id_login.getProfileData('age'));
  }

  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
</script>



<script>
  // CSRF 방지용 state 토큰 생성 (JavaScript)
  function generateState() {
    return [...crypto.getRandomValues(new Uint32Array(4))]
            .map(num => num.toString(36))
            .join('');
  }

  function initNaverLogin() {
    var naver_id_login = new naver_id_login(
            "02aFSrv2E53MWqQAERSx", // 클라이언트 ID
            "http://localhost:8080/member/callback.jsp" // redirect URI
    );

    var state = generateState(); // JS에서 생성
    sessionStorage.setItem("naver_state", state); // 콜백에서 검증하려면 저장

    naver_id_login.setButton("white", 3, 40);
    naver_id_login.setState(state);
    naver_id_login.setPopup();
    naver_id_login.init_naver_id_login();
  }

  // 페이지 로드 시 실행
  initNaverLogin();
</script>

<!--카카오 로그인 관련-->
<script>
  Kakao.init('e8b842dc97356296e338660ae4063b8a'); //발급받은 키 중 javascript키를 사용해준다.

  console.log(Kakao.isInitialized()); // sdk초기화여부판단

  displayToken();

  function displayToken() {
    var token = getCookie('authorize-access-token');

    if(token) {
      Kakao.Auth.setAccessToken(token);
      Kakao.Auth.getStatusInfo()
              .then(function(res) {
                if (res.status === 'connected') {
                  document.getElementById('token-result').innerText
                          = 'login success, token: ' + Kakao.Auth.getAccessToken();
                }
              })
              .catch(function(err) {
                Kakao.Auth.setAccessToken(null);
              });
    }
  }

  function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length === 2) { return parts[1].split(';')[0]; }
  }
  //redirect방식의 카카오 로그인
  function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'http://localhost:8080/Controller?type=kakaoLogin',
      scope: 'account_email,profile_nickname',

    });

  }
 // https://nid.naver.com/oauth2.0/authorize?client_id={클라이언트 아이디}&response_type=code&redirect_uri={개발자 센터에 등록한 콜백 URL(URL 인코딩)}&state={상태 토큰}

  /*//jdk 방식 카카오로그인
  function kakaoLogin() {
    //로그인 요청(회원가입)
    Kakao.Auth.login({
      success: function (response) {
        //회원 정보 가져오기
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
            $.ajax({
              url:'/user/kakaoLogin',
              type: 'post',
              data: {//동의항목을 카카오톡 닉네임과 이메일만 설정했기 때문에 이렇게만 가져옴 더추가하려면 동의항목을 늘리면됨
                'user_name' : response.properties.nickname,
                'user_email' : response.kakao_account.email
              },
              success: function(result){//로그인성공

                console.log(result);
                window.location.href='/';
              }
            });
          },
          fail: function (error) {//로그인 실패
            console.log(error);
          },
        })
                .then(function (response) {
                  console.log(response);
                })
      },
      fail: function (error) {
        console.log(error);
      },
    })
  };*/

  //로그아웃
  function Logout() {
    if (!Kakao.Auth.getAccessToken()) {
      alert('로그아웃 하였습니다.');
      window.location.href='/user/logout';
    }
    Kakao.Auth.logout(function (response) {
      alert('로그아웃 하였습니다.');
      window.location.href = '/user/logout';
    });
  };

  //카카오연결 끊기 및 회원 탈퇴
  /*$("#delete").click(function(){
    if(confirm("정말 삭제하시겠습니까?")){
      Kakao.API.request({
        url: '/v1/user/unlink',
      })
      $("#register").attr({
        'method' : 'post',
        'action' : '/user/delete'
      });
      $("#register").submit();
    }
  });*/


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