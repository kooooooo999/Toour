package toour.post.action;

import toour.action.Action;
import toour.post.dao.InquiryDAO;
import toour.member.vo.MemberVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

public class InquiryViewAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 세션 체크 및 로그인 상태 확인
        HttpSession session = request.getSession();
        if (session.getAttribute("member") == null) {
            request.setAttribute("error", "로그인이 필요한 서비스입니다.");
            return "Controller?type=moveLogin";
        }
        
        MemberVO loginMember = (MemberVO) session.getAttribute("member");
        if (loginMember == null || loginMember.getMember_idx() == null) {
            request.setAttribute("error", "유효하지 않은 사용자 정보입니다.");
            return "Controller?type=moveLogin";
        }
        
        String member_idx = loginMember.getMember_idx();
        
        // 문의 번호 받기
        String inquiry_idx = request.getParameter("inquiry_idx");
        if (inquiry_idx == null || inquiry_idx.trim().isEmpty()) {
            request.setAttribute("error", "잘못된 접근입니다.");
            return "Controller?type=inquiryList";
        }
        
        // 문의 상세 정보 조회 (본인 확인 포함)
        Map<String, Object> inquiry = InquiryDAO.getInquiryDetail(inquiry_idx, member_idx);
        
        if (inquiry == null) {
            request.setAttribute("error", "존재하지 않는 문의이거나 본인이 작성한 문의가 아닙니다.");
            return "Controller?type=inquiryList";
        }
        
        // 상태별 색상 설정
        String status = (String) inquiry.get("status");
        String statusColor;
        if ("대기중".equals(status)) {
            statusColor = "warning";
        } else if ("답변완료".equals(status)) {
            statusColor = "success";
        } else if ("처리중".equals(status)) {
            statusColor = "info";
        } else {
            statusColor = "secondary";
        }
        inquiry.put("statusColor", statusColor);
        
        // request에 데이터 저장
        request.setAttribute("inquiry", inquiry);
        
        return "post/inquiryView.jsp";
    }
}
