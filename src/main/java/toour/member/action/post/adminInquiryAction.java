// Corrected adminInquiryAction.java

package toour.member.action.post;

import toour.action.Action;
import toour.post.dao.InquiryDAO;
import toour.post.vo.InquiryVO;
import toour.util.Paging;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

public class adminInquiryAction extends InquiryDAO implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pageType = request.getParameter("pageType");
        String viewPath = "admin/admin_Inquiry.jsp";

        if ("inquiryDetails".equals(pageType)) {
            //문의글 상세보기
            viewPath = "admin/inquiryDetails.jsp";
            String idx = request.getParameter("idx");
            if (idx != null && !idx.isEmpty()) {
                // InquiryDAO에 있는 관리자용 상세 조회 메서드 사용
                Map<String, Object> inquiryData = InquiryDAO.getInquiryDetail(idx);

                String answer_content = request.getParameter("answer_content");
                InquiryDAO.updateInquirydata(idx, "답변완료", answer_content);

                // Map 데이터를 request에 설정합니다.
                request.setAttribute("reqInquiry", inquiryData);

            }
            request.setAttribute("searchType", request.getParameter("searchType"));
            request.setAttribute("searchStatus", request.getParameter("searchStatus"));
        }

        // 기존 문의 목록 조회 및 페이징 로직은 그대로 유지
        String searchType = request.getParameter("searchType");
        String searchStatus = request.getParameter("searchStatus");
        int cnt = InquiryDAO.getInquiryTotalCount(searchType, searchStatus);
        //Page 생성
        Paging page = new Paging(10, 5);
        if (cnt > 0) {
            page.setTotalCount(cnt);
        } else {
            page.setTotalCount(1);
        }

        String cPage = request.getParameter("cPage");
        if (cPage == null || cPage.isEmpty() || cPage.equals("null")) {
            page.setNowPage(1);
        } else {
            int nowPage = Integer.parseInt(cPage);
            page.setNowPage(nowPage);
        }

        InquiryVO[] IvoArr = InquiryDAO.getInquiryTotaldata(page.getBegin() - 1, page.getNumPerPage(), searchType, searchStatus);
        request.setAttribute("page", page);
        request.setAttribute("IvoArr", IvoArr);


        return viewPath;
    }
}