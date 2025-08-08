package toour.member.action;

import toour.action.Action;
import toour.member.dao.AdminPostDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminNoticeDelAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath = null;
        String post_idx = request.getParameter("post_idx");
        String cPage = request.getParameter("cPage");

        int cnt = AdminPostDAO.delnotice(post_idx);
        viewPath = "AdminController?type=adminnotice&cPage"+cPage;

        return viewPath;
    }
}
