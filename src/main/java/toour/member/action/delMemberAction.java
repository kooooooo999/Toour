package toour.member.action;


import toour.action.Action;
import toour.login.dao.MemberDAO;
import toour.member.vo.MemberVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class delMemberAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("delMemberAction");
        HttpSession session = request.getSession();
        Object obj = session.getAttribute("member");
        MemberVO mvo = null;
        if(obj != null){
            System.out.println("delMemberAction mvo !=null");
            mvo = (MemberVO) obj;
            MemberDAO.delOneMember(mvo.getMember_idx());
            session.removeAttribute("member");
        }

        return "gohome";
    }
}
