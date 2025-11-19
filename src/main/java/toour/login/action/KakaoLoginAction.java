package toour.login.action;

import toour.action.Action;
import toour.member.vo.MemberVO;
import toour.login.dao.MemberDAO;
import toour.util.ApiKeyUtil;
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
                    int cnt = MemberDAO.updateLastLogin(member.getMember_idx());
                    if (cnt > 0) {
                        member.setMember_last_login_at(String.valueOf(new Timestamp(System.currentTimeMillis())));
                    }
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
            session.setAttribute("userEmail", member.getMember_email());
            session.setAttribute("userNickName", member.getMember_nickname());
            session.setMaxInactiveInterval(30*60);// 세션 30분 유지
            //이게 뭐지?
            System.out.println("KaKaoMember_nickname is:"+member.getMember_nickname());
            return "gohome";

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "카카오 로그인 처리 중 오류 발생");
            return "member/login.jsp";
        }
    }

    // 카카오 토큰 요청 (디버깅 버전)
    private String getAccessToken(String code) throws IOException {
        String tokenUrl = "https://kauth.kakao.com/oauth/token";
        String redirectUri = "http://localhost:8080/Controller?type=kakaoLogin";
        String clientId = ApiKeyUtil.getKakaoRestKey();

        System.out.println("=== 토큰 요청 시작 ===");
        System.out.println("code: " + code);
        System.out.println("clientId: " + clientId);
        System.out.println("redirectUri: " + redirectUri);

        URL url = new URL(tokenUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        String params = "grant_type=authorization_code" +
                "&client_id=" + clientId +
                "&redirect_uri=" + redirectUri +
                "&code=" + code;

        try (BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()))) {
            bw.write(params);
            bw.flush();
        }

        int responseCode = conn.getResponseCode();
        System.out.println("토큰 요청 응답 코드: " + responseCode);

        if (responseCode == 200) {
            String result = readResponse(conn.getInputStream());
            System.out.println("토큰 응답: " + result);

            JSONObject json = new JSONObject(result);
            String accessToken = json.getString("access_token");
            System.out.println("발급된 액세스 토큰: " + accessToken);
            return accessToken;
        } else {
            // 에러 응답도 읽어보기
            String errorResult = "";
            try {
                errorResult = readResponse(conn.getErrorStream());
            } catch (Exception e) {
                errorResult = "에러 스트림을 읽을 수 없음";
            }
            System.out.println("토큰 요청 실패 - 응답 코드: " + responseCode);
            System.out.println("에러 응답: " + errorResult);
            return null;//오류페이지******************************************
        }
    }

    // 사용자 정보 요청 (디버깅 버전)
    private JSONObject getUserInfo(String accessToken) throws IOException {
        String reqUrl = "https://kapi.kakao.com/v2/user/me";

        System.out.println("=== 사용자 정보 요청 시작 ===");
        System.out.println("사용할 액세스 토큰: " + accessToken);

        URL url = new URL(reqUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);

        int responseCode = conn.getResponseCode();
        System.out.println("responseCode: " + responseCode);

        if (responseCode != 200) {
            String errorResult = "";
            try {
                errorResult = readResponse(conn.getErrorStream());
            } catch (Exception e) {
                errorResult = "error stream can't be read";
            }
            System.out.println("request failed error result: " + errorResult);
            throw new IOException("request failed, response code is " + responseCode);
        }

        String result = readResponse(conn.getInputStream());
        System.out.println("userInfo response: " + result);

        JSONObject json = new JSONObject(result);
        JSONObject kakaoAccount = json.getJSONObject("kakao_account");
        JSONObject profile = kakaoAccount.getJSONObject("profile");

        JSONObject userInfo = new JSONObject();
        userInfo.put("email", kakaoAccount.optString("email", null));
        userInfo.put("nickname", profile.optString("nickname", null));

        System.out.println("userInfo: " + userInfo.toString());
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
