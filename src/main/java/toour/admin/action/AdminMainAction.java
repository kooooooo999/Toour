package toour.admin.action;

import toour.action.Action;
import toour.admin.dao.AdminDAO;
import toour.member.vo.MemberVO;
import toour.post.vo.InquiryVO;

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
        int count =AdminDAO.getMyTotalCount();

        request.setAttribute("count", count);

        InquiryVO[] ar = AdminDAO.OneMonthQnAList();

        request.setAttribute("ar", ar);


        return viewPath;
    }
}
