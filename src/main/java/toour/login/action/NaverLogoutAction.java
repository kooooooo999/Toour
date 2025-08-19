package toour.login.action;

import toour.action.Action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

public class NaverLogoutAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. 현재 세션 가져오기
        HttpSession session = request.getSession(false); // 세션이 없으면 null 반환
        if(session != null) {

            // 2. 세션에서 네이버 access_token 가져오기
            String accessToken = (String) session.getAttribute("access_token");

            // 3. accessToken이 존재하면 네이버 로그아웃 API 호출
            if(accessToken != null) {
                String clientId = "02aFSrv2E53MWqQAERSx";          // 네이버 애플리케이션 Client ID
                String clientSecret = "48ZDNX7Aeo";  // 네이버 애플리케이션 Client Secret

                // 네이버 로그아웃(토큰 삭제) URL
                String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=delete"
                        + "&client_id=" + clientId
                        + "&client_secret=" + clientSecret
                        + "&access_token=" + accessToken
                        + "&service_provider=NAVER";

                // 4. HTTP GET 요청
                URL url = new URL(apiURL);
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                con.setRequestMethod("GET");
                int responseCode = con.getResponseCode(); // 응답 코드 확인
                System.out.println("Naver Logout Response Code: " + responseCode);
            }

            // 5. 세션 무효화 (로그아웃 처리)
            session.invalidate();
        }

        // 6. 로그아웃 후 이동할 페이지 경로 반환 (main.jsp 등)
        return "MainIndex/index.jsp";
    }
}
