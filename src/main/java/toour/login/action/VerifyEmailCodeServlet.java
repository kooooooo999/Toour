package toour.login.action;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/verifyEmailCode")
public class VerifyEmailCodeServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 응답 설정
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try {
            String inputCode = request.getParameter("code");
            HttpSession session = request.getSession();

            String savedCode = (String) session.getAttribute("emailAuthCode");
            Long savedTime = (Long) session.getAttribute("emailAuthCodeTime");
            
            System.out.println("verifyEmailCode - inputCode:" + inputCode);
            System.out.println("verifyEmailCode - savedCode:" + savedCode);
            
            boolean isMatch = false;
            String message = "";

            if (inputCode == null || inputCode.trim().isEmpty()) {
                message = "인증번호를 입력해주세요.";
            } else if (savedCode == null || savedTime == null) {
                message = "인증번호가 만료되었습니다. 다시 인증메일을 발송해주세요.";
            } else {
                long currentTime = System.currentTimeMillis();
                long elapsedTime = currentTime - savedTime;

                // 인증 유효시간: 10분
                if (elapsedTime <= 10 * 60 * 1000) {
                    isMatch = inputCode.trim().equals(savedCode);
                    if (isMatch) {
                        message = "인증이 완료되었습니다.";
                    } else {
                        message = "인증번호가 일치하지 않습니다.";
                    }
                } else {
                    message = "인증번호가 만료되었습니다. 다시 인증메일을 발송해주세요.";
                    // 만료된 인증 정보 삭제
                    session.removeAttribute("emailAuthCode");
                    session.removeAttribute("emailAuthCodeTime");
                }
            }

            // 인증 성공 후, 코드 및 시간 삭제
            if (isMatch) {
                session.removeAttribute("emailAuthCode");
                session.removeAttribute("emailAuthCodeTime");
            }

            // 응답 전송
            String jsonResponse = String.format("{\"success\": %s, \"message\": \"%s\"}", isMatch, message);
            response.getWriter().write(jsonResponse);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"처리 중 오류가 발생했습니다.\"}");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // GET 요청은 POST로 리다이렉트
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method not allowed");
    }
}