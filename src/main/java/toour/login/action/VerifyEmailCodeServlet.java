package toour.login.action;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/verifyEmailCode")
public class VerifyEmailCodeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String inputCode = request.getParameter("code");
        HttpSession session = request.getSession();

        String savedCode = (String) session.getAttribute("emailAuthCode");
        Long savedTime = (Long) session.getAttribute("emailAuthCodeTime");
        System.out.println("code:"+inputCode);
        boolean isMatch = false;

        if (savedCode != null && savedTime != null) {
            long currentTime = System.currentTimeMillis();
            long elapsedTime = currentTime - savedTime;

            // 인증 유효시간: 10분
            if (elapsedTime <= 10 * 60 * 1000) {
                isMatch = inputCode != null && inputCode.equals(savedCode);
            }
        }

        // 인증 성공 후, 코드 및 시간 삭제
        if (isMatch) {
            session.removeAttribute("emailAuthCode");
            session.removeAttribute("emailAuthCodeTime");
        }

        response.setContentType("application/json");
        response.getWriter().write("{\"success\": " + isMatch + "}");
        response.getWriter().flush();
    }
}