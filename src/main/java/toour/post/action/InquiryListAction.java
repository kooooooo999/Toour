package toour.post.action;

import toour.action.Action;
import toour.post.dao.InquiryDAO;
import toour.member.vo.MemberVO;
import toour.post.vo.InquiryVO;
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
        // 검색 조건
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        String category = request.getParameter("category");

        // 페이징 처리
        int totalRecord = InquiryDAO.getTotalCount(member_idx, null, null, null);

        Paging page = new Paging(5, 5);
        page.setTotalCount(totalRecord);

        String cPage = request.getParameter("cPage");
        System.out.println("cPage"+cPage);
        if (cPage == null||cPage.equals("")) {
            page.setNowPage(1);
        }
        else{
            int nowPage= Integer.parseInt(cPage);
            page.setNowPage(nowPage);
        }

        if (cPage == null) {cPage = "1";}
        int nowPage = (cPage != null) ? Integer.parseInt(cPage) : 1;


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
        
        InquiryVO[] inquiryList = InquiryDAO.getByMember_idx(member_idx);

        
        // 상태별 색상 매핑
        for (InquiryVO inquiry : inquiryList) {
            String status = (String) inquiry.getStatus();
            if ("대기".equals(status)) {
                inquiry.setStatusColor("warning");
            } else if ("답변완료".equals(status)) {
                inquiry.setStatusColor("success");
            } else if ("처리중".equals(status)) {
                inquiry.setStatusColor("info");
            } else {
                inquiry.setStatusColor("secondary");
            }
        }
        System.out.println("inquiryAction inquiryList.length: "+inquiryList.length);
        // request에 데이터 저장
        request.setAttribute("QnAcPage", cPage);
        request.setAttribute("myInquiryList", inquiryList);
        request.setAttribute("InquiryPage", page);
        request.setAttribute("QnAsearchType", searchType);
        request.setAttribute("QnAsearchValue", searchValue);
        request.setAttribute("category", category);
        request.setAttribute("QnAtotalCount",totalRecord);
        request.setAttribute("QnAnowPage",page.getNowPage());



        return "member/myPage.jsp";
    }
}
