package toour.login.action;

import toour.action.Action;
import toour.login.dao.MemberDAO;
import toour.member.vo.MemberVO;
import toour.util.Hash;
import toour.util.Salt;
import toour.util.EmailUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jakarta.mail.MessagingException;

public class FindPasswordAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String member_id = request.getParameter("member_id");
        String member_name = request.getParameter("member_name");
        String member_email = request.getParameter("member_email");
        
        if (member_id != null && member_name != null && member_email != null) {
            // 아이디, 이름, 이메일로 회원 정보 조회
            MemberVO member = MemberDAO.findMemberByIdNameAndEmail(member_id, member_name, member_email);
            
            if (member != null) {
                try {
                    // 임시 비밀번호 생성 (8자리 랜덤)
                    String tempPassword = generateTempPassword();
                    
                    // 새로운 salt 생성
                    String newSalt = Salt.getSalt();
                    
                    // 임시 비밀번호를 해시화
                    String hashedTempPassword = Hash.getHash(newSalt + tempPassword);
                    
                    // DB 업데이트: 임시 비밀번호, salt, is_temp_password 플래그
                    int updateResult = MemberDAO.updateTempPassword(member.getMember_idx(), hashedTempPassword, newSalt);
                    
                    if (updateResult > 0) {
                        // 임시 비밀번호 이메일 전송
                        EmailUtil.sendTempPasswordEmail(member_email, tempPassword);
                        
                        request.setAttribute("success", true);
                        request.setAttribute("message", "임시 비밀번호가 이메일로 전송되었습니다.");
                    } else {
                        request.setAttribute("success", false);
                        request.setAttribute("message", "비밀번호 업데이트에 실패했습니다.");
                    }
                    
                } catch (MessagingException e) {
                    e.printStackTrace();
                    request.setAttribute("success", false);
                    request.setAttribute("message", "이메일 전송에 실패했습니다.");
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("success", false);
                    request.setAttribute("message", "처리 중 오류가 발생했습니다.");
                }
            } else {
                request.setAttribute("success", false);
                request.setAttribute("message", "입력하신 정보와 일치하는 회원이 없습니다.");
            }
        } else {
            request.setAttribute("success", false);
            request.setAttribute("message", "모든 정보를 입력해주세요.");
        }
        
        return "member/findPassword.jsp";
    }
    
    // 8자리 임시 비밀번호 생성 (영문 대소문자 + 숫자)
    private String generateTempPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        java.util.Random random = new java.util.Random();
        
        for (int i = 0; i < 8; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        
        return sb.toString();
    }
}
