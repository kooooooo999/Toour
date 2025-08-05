package toour.member.action;

import toour.action.Action;
import toour.member.dao.AdminMemberDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemDelAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath = null;

        String member_idx = request.getParameter("member_idx");
        String cPage = request.getParameter("cPage");

        int cnt = AdminMemberDAO.delMem(member_idx);
        viewPath = "AdminController?type=adminmemlist&cPage="+cPage;

        return viewPath;
    }
}
