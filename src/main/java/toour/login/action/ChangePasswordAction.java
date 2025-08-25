package toour.login.action;

import toour.action.Action;
import toour.login.dao.MemberDAO;
import toour.member.vo.MemberVO;
import toour.util.Hash;
import toour.util.Salt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ChangePasswordAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        MemberVO member = (MemberVO) session.getAttribute("member");
        
        // 로그인 상태 확인
        if (member == null) {
            request.setAttribute("error", "로그인이 필요합니다.");
            return "member/login.jsp";
        }
        
        // 임시 비밀번호 사용자만 접근 가능
        if (!"1".equals(member.getIs_temp_password())) {
            request.setAttribute("error", "이미 일반 비밀번호를 사용하고 있습니다.");
            return "gohome";
        }
        
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");
        
        // 입력값 검증
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("error", "새 비밀번호를 입력해주세요.");
            return "member/changePassword.jsp";
        }
        
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "비밀번호 확인을 입력해주세요.");
            return "member/changePassword.jsp";
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "member/changePassword.jsp";
        }
        
        if (newPassword.length() < 8) {
            request.setAttribute("error", "비밀번호는 8자 이상이어야 합니다.");
            return "member/changePassword.jsp";
        }
        
        if (!newPassword.matches("^(?=.*[a-zA-Z])(?=.*[0-9]).*$")) {
            request.setAttribute("error", "비밀번호는 영문과 숫자를 포함해야 합니다.");
            return "member/changePassword.jsp";
        }
        
        try {
            // 새로운 salt 생성
            String newSalt = Salt.getSalt();
            
            // 새 비밀번호 해시화
            String hashedPassword = Hash.getHash(newSalt + newPassword);
            
            // MemberVO 업데이트
            member.setMember_password(hashedPassword);
            member.setMember_salt(newSalt);
            member.setIs_temp_password("0"); // 임시 비밀번호 플래그를 0으로 설정
            
            // DB 업데이트
            MemberDAO.updateMyInfo(member);
            
            // 세션 업데이트
            session.setAttribute("member", member);
            
            request.setAttribute("success", "비밀번호가 성공적으로 변경되었습니다. 메인 페이지로 이동합니다.");
            
            // 3초 후 메인 페이지로 리다이렉트
            response.setHeader("Refresh", "3;url=Controller?type=gohome");
            
            return "member/changePassword.jsp";
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "비밀번호 변경 중 오류가 발생했습니다. 다시 시도해주세요.");
            return "member/changePassword.jsp";
        }
    }
}
