package toour.login.action;

import toour.action.Action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class KakaoLogoutAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //카카오 로그아웃
        HttpSession session = request.getSession(false);
        if(session!=null){
            session.removeAttribute("accessToken");
            session.removeAttribute("member");
            session.removeAttribute("user");
            session.removeAttribute("userIdx");
            session.removeAttribute("userEmail");
            session.removeAttribute("userNickName");
        }
        return "MainIndex/index.jsp";
    }
}
