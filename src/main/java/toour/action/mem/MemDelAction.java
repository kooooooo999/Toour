package toour.action.mem;

import toour.action.Action;
import toour.dao.memDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemDelAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath = null;

        String member_idx = request.getParameter("member_idx");
        String cPage = request.getParameter("cPage");

        int cnt = memDAO.delMem(member_idx);
        viewPath = "Controller?type=adminmemlist&cPage="+cPage;

        return viewPath;
    }
}
