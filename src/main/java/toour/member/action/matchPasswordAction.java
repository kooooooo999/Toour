package toour.member.action;

import toour.action.Action;
import toour.member.vo.MemberVO;
import toour.util.Hash;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class matchPasswordAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String u_pw = request.getParameter("u_pw");
        MemberVO mvo = null;
        boolean t = false;
        if(u_pw !=null){
            Object obj = request.getSession().getAttribute("member");
            if(obj!=null){
                mvo =(MemberVO) obj;
                String salt = mvo.getMember_salt();
                String hash_pw = Hash.getHash(salt+u_pw);
                if(mvo.getMember_password().equals(hash_pw)) {
                    //비밀번호가 맞았을 때
                    t = true;
                }
            }
        }

        request.setAttribute("bol",t);

        return "member/matchPW.jsp";
    }
}
