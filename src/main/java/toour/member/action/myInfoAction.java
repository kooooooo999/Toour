package toour.member.action;

import toour.action.Action;
import toour.login.dao.MemberDAO;
import toour.member.vo.MemberVO;
import toour.util.Hash;
import toour.util.Salt;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class myInfoAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("myInfoAction");
        String u_pw = request.getParameter("u_pw");
        String u_nickname = request.getParameter("u_nickname");

        //1번 경우 아무것도 변경하지 않고 버튼을 눌렀음 -> 아무것도 안하고 복귀
        //2번 경우 비밀번호만 바꿨음 -> hash값 새로 만들어서 비밀번호랑 합친후 hash된 비밀번호와 hash 둘 다 저장
        //3번 경우 닉네임만 바꿨음 -> 닉네임만 변경
        //4번 경우 둘 다 변경했음 -> 2번, 3번 둘 다 시행

        //변경될 hash 처리된 비밀번호
        String changePW = null;

        Object obj = request.getSession().getAttribute("member");
        MemberVO mvo = null;

        if (obj != null) {
            mvo = (MemberVO) obj;
            mvo.setMember_nickname(u_nickname);
        }
        if (mvo.getMember_type().equals("LOCAL")){
            if (u_pw.trim().length() < 1) {
                // 비밀번호 변경 없음
            } else {
                String salt = Salt.getSalt();
                changePW = Hash.getHash(salt + u_pw);
                mvo.setMember_salt(salt);
                mvo.setMember_password(changePW);
                // 비밀번호 변경 시 임시 비밀번호 플래그를 0으로 설정
                mvo.setIs_temp_password("0");
            }
        MemberDAO.updateMyInfo(mvo);
        }else
            MemberDAO.updateKakaoMyInfo(mvo);

        return "";
    }

}
