package toour.member.action;

import toour.action.Action;
import toour.login.dao.MemberDAO;
import toour.member.dao.AdminMemberDAO;
import toour.member.dao.AdminNoticeDAO;
import toour.member.vo.MemberVO;
import toour.util.Hash;
import toour.util.Salt;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminMemInfoAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String member_idx = request.getParameter("member_idx");
        String u_nickname = request.getParameter("u_nickname");
        String u_name = request.getParameter("u_name");
        String u_email = request.getParameter("u_email");
        String u_email2 = request.getParameter("u_email2");
        String u_warning = request.getParameter("u_warning");

        if(member_idx == null) {
            throw new IllegalArgumentException("member_idx가 전달");
        }

        MemberVO changeMvo = new MemberVO();
        changeMvo.setMember_idx(String.valueOf(Integer.parseInt(member_idx)));
        changeMvo.setMember_nickname(u_nickname);
        changeMvo.setMember_name(u_name);
        changeMvo.setMember_email(u_email+"@"+u_email2);

        //warning에 null값 들어가는 거 방지
        int warningValue = 0;
        try {
            if (u_warning != null && !u_warning.trim().equals("")) {
                warningValue = Integer.parseInt(u_warning);
            }
        } catch (NumberFormatException e) {
            warningValue = 0;
        }

        changeMvo.setMember_warning(String.valueOf(Integer.parseInt(String.valueOf(warningValue))));

        MemberVO vo = AdminMemberDAO.view(member_idx);

        MemberDAO.updateMemInfo(changeMvo);

        request.setAttribute("vo", vo);

        return "";
    }
}
