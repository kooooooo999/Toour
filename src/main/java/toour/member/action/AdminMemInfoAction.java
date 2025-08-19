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
        changeMvo.setMember_warning(String.valueOf(Integer.parseInt(u_warning)));

        MemberVO vo = MemberDAO.getMem(member_idx);

        MemberDAO.updateMemInfo(changeMvo);  // 회원 idx 기준 DB만 변경

        request.setAttribute("vo", vo);

        // 다시 목록 페이지나 상세페이지로 리디렉트
        return "redirect:AdminController?type=adminmemlist";
    }
}
