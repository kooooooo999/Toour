package toour.admin.action;

import toour.action.Action;
import toour.member.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminMainAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath = "MainIndex/index.jsp";
        Object obj = request.getSession().getAttribute("member");
        MemberVO mvo = null;
        if(obj != null) {
            //로그인을 함
            mvo = (MemberVO) obj;

            if (mvo.getMember_type().equals("0")) {
                viewPath = "admin/admin_main.jsp";
            }

        }
        return viewPath;
    }
}
