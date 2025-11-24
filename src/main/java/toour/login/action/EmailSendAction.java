package toour.login.action;

import jakarta.mail.MessagingException;
import toour.util.EmailUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/sendEmailAuth")
public class EmailSendAction extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 응답 설정
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try {
            String email = request.getParameter("email");
            if (email != null) {
                email = email.trim().replaceAll("\\s", "");
            }
            
            // 이메일 유효성 검사
            if (email == null || email.isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"이메일을 입력해주세요.\"}");
                return;
            }

            String authCode = String.valueOf((int)(Math.random() * 900000) + 100000);
            HttpSession session = request.getSession();

            Long lastSent = (Long) session.getAttribute("lastEmailSentTime");
            long now = System.currentTimeMillis();

            if (lastSent != null && now - lastSent < 60 * 1000) {
                response.getWriter().write("{\"success\": false, \"message\": \"1분 뒤 다시 시도하세요.\"}");
                return;
            }

            // 이메일 전송
            EmailUtil.sendAuthEmail(email, authCode);

            // 세션에 인증 정보 저장
            session.setAttribute("emailAuthCode", authCode);
            session.setAttribute("emailAuthCodeTime", now);
            session.setAttribute("lastEmailSentTime", now);

            // 성공 응답
            response.getWriter().write("{\"success\": true, \"message\": \"인증 메일이 전송되었습니다.\"}");
            
        } catch (MessagingException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"메일 전송에 실패했습니다.\"}");
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
