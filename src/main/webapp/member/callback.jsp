<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="toour.login.dao.MemberDAO" %>
<%@ page import="toour.member.vo.MemberVO" %>
<%@ page import="java.sql.Timestamp" %><%--
  Created by IntelliJ IDEA.
  User: 쌍용교육센터
  Date: 25. 8. 8.
  Time: 오전 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<body>
<%
    int a=0;
    String clientId = "02aFSrv2E53MWqQAERSx";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "48ZDNX7Aeo";//애플리케이션 클라이언트 시크릿값";
    //인증코드
    String code = request.getParameter("code");
    String state = (String) request.getSession().getAttribute("state");
    System.out.println("code:"+code);
    System.out.println("state:"+state);

    // CSRF 방지 state 체크
    String storedState = (String) session.getAttribute("state");
    if (storedState == null || !storedState.equals(state)) {
        out.println("잘못된 접근입니다.");
        return;
    }
    //  네이버 OAuth 토큰 요청 URL 생성

    String redirectURI = URLEncoder.encode("http://localhost:8080/member/callback.jsp", "UTF-8");
    String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
            + "&client_id=" + clientId
            + "&client_secret=" + clientSecret
            + "&redirect_uri=" + redirectURI
            + "&code=" + code
            + "&state=" + state;
    //토큰 요청
    URL url = new URL(apiURL);
    HttpURLConnection con = (HttpURLConnection) url.openConnection();
    con.setRequestMethod("GET");
    //응답 읽기
    BufferedReader br = (con.getResponseCode() == 200)
            ? new BufferedReader(new InputStreamReader(con.getInputStream()))
            : new BufferedReader(new InputStreamReader(con.getErrorStream()));

    String inputLine;
    StringBuffer res = new StringBuffer();
    while ((inputLine = br.readLine()) != null) {
        res.append(inputLine);
    }
    br.close();

    //JSON 파싱: access_token 추출
    JSONObject json = new JSONObject(res.toString());
    String accessToken = json.getString("access_token");

    // 프로필 API 호출
    String header = "Bearer " + accessToken;
    String profileURL = "https://openapi.naver.com/v1/nid/me";
    URL url2 = new URL(profileURL);
    HttpURLConnection con2 = (HttpURLConnection) url2.openConnection();
    con2.setRequestMethod("GET");
    con2.setRequestProperty("Authorization", header);

    //프로필 응답 읽기
    BufferedReader br2 = new BufferedReader(new InputStreamReader(con2.getInputStream()));
    StringBuffer profileRes = new StringBuffer();
    while ((inputLine = br2.readLine()) != null) {
        profileRes.append(inputLine);
    }
    br2.close();

    //JSON 파싱: 사용자 정보 추출
    JSONObject profileJson = new JSONObject(profileRes.toString());
    JSONObject responseObj = profileJson.getJSONObject("response");

    String id = responseObj.getString("id");
    String nickname = responseObj.getString("nickname");
    String email = responseObj.optString("email");

    // aDB 저장: 이미 존재하면 무시, 없으면 추가
    MemberVO mvo = MemberDAO.getNaverMember(email); // DB에서 이미 존재하는지 확인
    if(mvo == null) {
        // 새 회원이면 MemberVO 생성 후 DB 저장
        MemberVO newMember = new MemberVO();
        newMember.setMember_id(null); // 기존 회원 아이디 없음
        newMember.setMember_nickname(nickname);
        newMember.setMember_email(email);
        newMember.setLogin_type("NAVER");   // 로그인 타입
        newMember.setMember_status("0");    // 상태
        newMember.setMember_type("1");      // 회원 타입
        newMember.setMember_password(null); // 비밀번호 없음
        newMember.setMember_salt(null);     // 솔트 없음
        newMember.setMember_last_login_at(String.valueOf(new Timestamp(System.currentTimeMillis())));

        MemberDAO.addMem(newMember); // DB 저장
        mvo = newMember; // 세션용
    } else {
        // 기존 회원이면 마지막 로그인 시간 갱신
        MemberDAO.updateLastLogin(mvo.getMember_idx());
    }

    // 12. 세션에 로그인 정보 저장
    session.setAttribute("accessToken", accessToken);
    session.setAttribute("member", mvo);
    session.setAttribute("userIdx", mvo.getMember_idx());
    session.setAttribute("userEmail", mvo.getMember_email());
    session.setAttribute("userNickName", mvo.getMember_nickname());
    try {
        int cnt = MemberDAO.updateLastLogin(mvo.getMember_idx());
        if (cnt > 0) {
            mvo.setMember_last_login_at(String.valueOf(new Timestamp(System.currentTimeMillis())));
        }
    } catch (Exception e) {
        e.printStackTrace();
        throw new RuntimeException(e);
    }

    session.setMaxInactiveInterval(30*60); // 세션 30분 유지

    // 13. 메인 페이지로 리다이렉트
    response.sendRedirect("/member/myPage.jsp");
%>

</body>
</html>

