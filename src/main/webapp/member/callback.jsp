<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %><%--
  Created by IntelliJ IDEA.
  User: 쌍용교육센터
  Date: 25. 8. 8.
  Time: 오전 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<<html lang="ko">--%>
<%--<head>--%>
<%--    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>--%>
<%--    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>--%>
<%--</head>--%>

<%--<body>--%>
<%--<script type="text/javascript">--%>
<%--    var naver_id_login = new naver_id_login("WqKlg2ns39WEN3SEtV0G", "http://localhost:8080/Controller?type=moveLogin");--%>
<%--    // 접근 토큰 값 출력--%>
<%--    alert(naver_id_login.oauthParams.access_token);--%>
<%--    // 네이버 사용자 프로필 조회--%>
<%--    naver_id_login.get_naver_userprofile("naverSignInCallback()");--%>
<%--    // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function--%>
<%--    function naverSignInCallback() {--%>
<%--        alert(naver_id_login.getProfileData('email'));--%>
<%--        alert(naver_id_login.getProfileData('nickname'));--%>
<%--        alert(naver_id_login.getProfileData('age'));--%>
<%--    }--%>
<%--</script>--%>

<%--</body>--%>
<%--</html>--%>

</head>
<body>
<%

    String clientId = "WqKlg2ns39WEN3SEtV0G";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "eWWORJKfvA";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = (String) request.getSession().getAttribute("state");
    System.out.println("code:"+code);
    System.out.println("state:"+state);
    String redirectURI = URLEncoder.encode("http://localhost:8080/member/callback.jsp", "UTF-8");
    String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
            + "&client_id=" + clientId
            + "&client_secret=" + clientSecret
            + "&redirect_uri=" + redirectURI
            + "&code=" + code
            + "&state=" + state;
    String accessToken = "";
    String refresh_token = "";
    try {

        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();
        BufferedReader br;
        if (responseCode == 200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuilder res = new StringBuilder();
        while ((inputLine = br.readLine()) != null) {
            res.append(inputLine);
        }
        br.close();
        if (responseCode == 200) {
            out.println(res.toString());
        }
    } catch (Exception e) {
        // Exception 로깅
        e.printStackTrace();
    }
%>

</body>
</html>

