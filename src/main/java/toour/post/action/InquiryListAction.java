package toour.post.action;

import toour.action.Action;
import toour.post.dao.InquiryDAO;
import toour.member.vo.MemberVO;
import toour.util.Paging;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class InquiryListAction implements Action {
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
        
        // 페이징 처리
        String cPage = request.getParameter("cPage");
        if (cPage == null) {
            cPage = "1";
        }
        
        int nowPage = Integer.parseInt(cPage);
        int numPerPage = 10; // 한 페이지당 보여줄 문의 수
        int totalRecord = InquiryDAO.getTotalCount(member_idx, null, null, null);
        
        Paging page = new Paging(numPerPage, 5);
        page.setTotalCount(totalRecord);
        page.setNowPage(nowPage);
        
        // 검색 조건
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        String category = request.getParameter("category");
        
        // 검색 조건이 있는 경우 전체 개수 다시 계산
        if ((searchType != null && !searchType.isEmpty()) || 
            (searchValue != null && !searchValue.isEmpty()) ||
            (category != null && !category.isEmpty())) {
            totalRecord = InquiryDAO.getTotalCount(member_idx, category, searchType, searchValue);
            page.setTotalCount(totalRecord);
        }
        
        // 문의 목록 조회
        int begin = page.getBegin();
        int end = page.getEnd();
        
        List<Map<String, Object>> inquiryList = InquiryDAO.getInquiryList(
            member_idx, category, searchType, searchValue, begin, end);
        
        // 상태별 색상 매핑
        for (Map<String, Object> inquiry : inquiryList) {
            String status = (String) inquiry.get("status");
            if ("대기중".equals(status)) {
                inquiry.put("statusColor", "warning");
            } else if ("답변완료".equals(status)) {
                inquiry.put("statusColor", "success");
            } else if ("처리중".equals(status)) {
                inquiry.put("statusColor", "info");
            } else {
                inquiry.put("statusColor", "secondary");
            }
        }
        
        // request에 데이터 저장
        request.setAttribute("inquiryList", inquiryList);
        request.setAttribute("page", page);
        request.setAttribute("searchType", searchType);
        request.setAttribute("searchValue", searchValue);
        request.setAttribute("category", category);
        
        return "/post/inquiryList.jsp";
    }
}
