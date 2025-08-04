package toour.login.action;

import toour.action.Action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class moveLoginAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        return "member/login.jsp";
    }
}
