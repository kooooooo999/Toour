package toour.login.action;

import jakarta.mail.MessagingException;
import toour.action.Action;
import toour.util.EmailUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
@WebServlet("/sendEmailAuth")
public class EmailSendAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json"); // 응답 컨텐츠 타입 미리 설정

        String email = request.getParameter("email");
        if (email != null) {
            email = email.trim().replaceAll("\\s", "");
        }
        System.out.println("EmailSendAction email:" + email);


        String authCode = String.valueOf((int)(Math.random() * 900000) + 100000);
        HttpSession session = request.getSession();

        Long lastSent = (Long) session.getAttribute("lastEmailSentTime");
        long now = System.currentTimeMillis();

        if (lastSent != null && now - lastSent < 60 * 1000) {
            response.getWriter().write("{\"success\": false, \"message\": \"1분 뒤 다시 시도하세요.\"}");
            return; // 중요!
        }

        try {
            EmailUtil.sendAuthEmail(email, authCode);

            session.setAttribute("emailAuthCode", authCode);
            session.setAttribute("emailAuthCodeTime", now);
            session.setAttribute("lastEmailSentTime", now); // 추가

            response.getWriter().write("{\"success\": true}");
        } catch (MessagingException e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"메일 전송 실패\"}");
        }
    }
}
