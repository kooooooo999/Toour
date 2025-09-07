package toour.course.action;

import java.awt.*;
import java.io.IOException;

import toour.action.Action;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TutorialAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String method = request.getMethod();
        String action = request.getParameter("action");

        // POST 요청일 경우 쿠키 처리
        if ("POST".equalsIgnoreCase(method)) {
            if ("skipToday".equals(action)) {
                // 하루짜리 쿠키 생성
                Cookie cookie = new Cookie("skipTutorial", "true");
                cookie.setMaxAge(60 * 60 * 24); // 1일
                cookie.setPath(request.getContextPath());
                response.addCookie(cookie);

            } else if ("reset".equals(action)) {
                // 쿠키 삭제
                Cookie cookie = new Cookie("skipTutorial", "");
                cookie.setMaxAge(0);
                cookie.setPath(request.getContextPath());
                response.addCookie(cookie);
            }
        }

        // 쿠키 확인 → 모달 표시 여부 결정
        boolean skipTutorial = false;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("skipTutorial".equals(c.getName())) {
                    skipTutorial = true;
                    break;
                }
            }
        }

        request.setAttribute("showTutorial", !skipTutorial);

        // JSP forward
        return "findWay.jsp";
    }


}
