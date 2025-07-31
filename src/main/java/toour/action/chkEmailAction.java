package toour.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class chkEmailAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String email = request.getParameter("u_email");
        String emailAddr = request.getParameter("emailAddr");




        return "inspection.jsp";
    }
}
