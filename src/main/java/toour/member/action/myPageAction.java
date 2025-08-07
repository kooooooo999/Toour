package toour.member.action;

import toour.action.Action;
import toour.member.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class myPageAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        Object obj = request.getSession().getAttribute("user");
        if(obj !=null){
            MemberVO mvo = (MemberVO) obj;

        }

        return "member/myPage.jsp";
    }
}
