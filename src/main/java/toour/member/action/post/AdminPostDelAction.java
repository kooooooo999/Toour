package toour.member.action.post;

import toour.action.Action;
import toour.member.dao.AdminPostDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminPostDelAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath = null;
        String post_idx = request.getParameter("post_idx");
        String cPage = request.getParameter("cPage");

        int cnt = AdminPostDAO.delnotice(post_idx);
        viewPath = "AdminController?type=adminpost&cPage"+cPage;

        return viewPath;
    }
}
