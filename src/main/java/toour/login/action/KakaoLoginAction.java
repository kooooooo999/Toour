package toour.login.action;

import toour.action.Action;
import toour.member.vo.MemberVO;
import toour.login.dao.MemberDAO;
import org.json.JSONObject;

import javax.servlet.http.*;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;

public class KakaoLoginAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            // 1. 카카오가 전달한 code 받기
            String code = request.getParameter("code");
            if (code == null || code.isEmpty()) {
                request.setAttribute("msg", "카카오 인증 코드가 없습니다.");
                System.out.println("code is null");
                return "member/login.jsp";
            }

            // 2. 토큰 요청
            String token = getAccessToken(code);

            if (token == null) {
                request.setAttribute("msg", "카카오 토큰 발급 실패");
                System.out.println("token is null");
                return "member/login.jsp";
            }

            // 3. 사용자 정보 요청
            JSONObject userInfo = getUserInfo(token);
            String account_email = userInfo.optString("email", null);
            String profile_nickname = userInfo.optString("nickname", null);

            if (account_email == null) {
                System.out.println("account_email is null");
                request.setAttribute("msg", "카카오 로그인에 실패했습니다. 이메일 정보를 확인하세요.");
                return "member/login.jsp";
            }

            // 4. DB 처리
            //db정보랑 대조

            MemberVO member = MemberDAO.getKakaoMember("KAKAO", account_email);
            System.out.println("kakaomember_idx is:"+member.getMember_idx());

            if (member == null) {
                System.out.println("member is null");
                //정보가 없으니까 회원가입
                MemberVO newMember = new MemberVO();
                newMember.setMember_id(null);
                newMember.setMember_nickname(profile_nickname);
                newMember.setMember_email(account_email);
                newMember.setLogin_type("KAKAO");
                newMember.setMember_status("0");
                newMember.setMember_type("1");
                newMember.setMember_password(null);
                newMember.setMember_salt(null);

                MemberDAO.addMem(newMember);
                member = newMember;
            } else {
                System.out.println("kakao member already exist");
                //기존회원으로 마지막 로그인 날짜만 업데이트
                try {
                    MemberDAO.updateLastLogin(member.getMember_idx());
                    member.setMember_last_login_at(String.valueOf(new Timestamp(System.currentTimeMillis())));
                } catch (Exception e) {
                    e.printStackTrace();
                    throw new RuntimeException(e);
                }
            }

            // 5. 세션 저장
            HttpSession session = request.getSession();
            session.setAttribute("accessToken", token);
            session.setAttribute("member", member);
            session.setAttribute("userIdx", member.getMember_idx());
            session.setAttribute("userId", member.getMember_id());
            session.setAttribute("userNickName", member.getMember_nickname());
            System.out.println("KaKaoMember_nickname is:"+member.getMember_nickname());
            return "MainIndex/index.jsp";

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "카카오 로그인 처리 중 오류 발생");
            return "member/login.jsp";
        }
    }

    // 카카오 토큰 요청
    private String getAccessToken(String code) throws IOException {
        String tokenUrl = "https://kauth.kakao.com/oauth/token";
        String redirectUri = "http://localhost:8080/Controller?type=kakaoLogin"; // 동일해야 함
        String clientId = "f08deb4abc2cec584eecade447daf3bf"; // 여기에 REST API 키 입력

        URL url = new URL(tokenUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);

        String params = "grant_type=authorization_code" +
                "&client_id=" + clientId +
                "&redirect_uri=" + redirectUri +
                "&code=" + code;

        try (BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()))) {
            bw.write(params);
            bw.flush();
        }

        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
            String result = readResponse(conn.getInputStream());
            JSONObject json = new JSONObject(result);

            System.out.println("Access Token Response: " + result);

            return json.getString("access_token");
        }
        return params;
    }

    // 사용자 정보 요청
    private JSONObject getUserInfo(String accessToken) throws IOException {
        String reqUrl = "https://kapi.kakao.com/v2/user/me";

        URL url = new URL(reqUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        String result = readResponse(conn.getInputStream());
        JSONObject json = new JSONObject(result);

        JSONObject kakaoAccount = json.getJSONObject("kakao_account");
        JSONObject profile = kakaoAccount.getJSONObject("profile");

        JSONObject userInfo = new JSONObject();
        userInfo.put("email", kakaoAccount.optString("email", null));
        userInfo.put("nickname", profile.optString("nickname", null));

        return userInfo;
    }

    // 응답 읽기
    private String readResponse(InputStream is) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        br.close();
        return sb.toString();
    }
}
