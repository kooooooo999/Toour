package toour.member.action;

import toour.action.Action;
import toour.login.dao.MemberDAO;
import toour.member.dao.AdminMemberDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminMainAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AdminMainAction 실행됨");

        String member_idx = request.getParameter("member_idx");
        if (member_idx == null)
            member_idx = "1";

        int totalCount = AdminMemberDAO.getTotalMemCount();
        System.out.println("totalCount"+totalCount);

        request.setAttribute("totalCount", totalCount);

        return "admin_main.jsp";
    }
}
