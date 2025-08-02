package toour.login.action;

import toour.action.Action;
import toour.member.vo.MemberVO;
import toour.login.dao.MemberDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class chkNicknameAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String u_nickname =request.getParameter("u_nickname");

        boolean usable = false;
        String alertText = null;

        //아이디 최소 길이
        int nickname_len = 2;

        if(u_nickname !=null){
            MemberVO mvo = MemberDAO.getMemN(u_nickname);
            if(mvo!=null){
                // 중복 id가 있으으로 사용 불가능
                alertText = "이미 사용 중인 닉네임입니다.";
            }else{
                if(u_nickname.length()>=nickname_len) {
                    alertText = "사용 가능한 닉네임입니다!";
                    usable= true;
                }else{
                    alertText = nickname_len+"자 이상 기입해주세요";
                }
            }
        }
        request.setAttribute("usable",usable);
        request.setAttribute("alertText",alertText);
        return "inspection.jsp";
    }
}
