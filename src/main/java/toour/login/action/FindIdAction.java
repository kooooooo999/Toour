package toour.login.action;

import toour.action.Action;
import toour.login.dao.MemberDAO;
import toour.member.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FindIdAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String member_name = request.getParameter("member_name");
        String member_email = request.getParameter("member_email");
        
        if (member_name != null && member_email != null) {
            // 이름과 이메일로 회원 정보 조회
            MemberVO member = MemberDAO.findMemberByNameAndEmail(member_name, member_email);
            
            if (member != null) {
                // 회원 정보가 있으면 아이디 반환
                request.setAttribute("found_id", member.getMember_id());
                request.setAttribute("success", true);
            } else {
                // 회원 정보가 없으면 실패 메시지
                request.setAttribute("success", false);
                request.setAttribute("message", "입력하신 정보와 일치하는 회원이 없습니다.");
            }
        } else {
            request.setAttribute("success", false);
            request.setAttribute("message", "이름과 이메일을 모두 입력해주세요.");
        }
        
        return "member/findId.jsp";
    }
}
