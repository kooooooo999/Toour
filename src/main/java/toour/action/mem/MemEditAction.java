package toour.action.mem;

import toour.action.Action;
import toour.dao.MemberDAO;
import toour.dao.memDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemEditAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath = null;
        String cPage = request.getParameter("cPage");

        String member_idx = request.getParameter("member_idx");
        String member_name = request.getParameter("member_name");
        String member_nickname = request.getParameter("member_nickname");
        String member_password = request.getParameter("member_password");
        String member_email = request.getParameter("member_email");
        String member_id = request.getParameter("member_id");

        //DB에 저장
        int cnt = memDAO.Re(member_idx, member_name, member_nickname, member_password, member_email, member_id);

        viewPath = "Controller?type=adminmemlist&b_idx=" + member_idx + "&cPage=" + cPage;

        return viewPath;
    }
}



