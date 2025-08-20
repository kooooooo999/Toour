package toour.member.action.post;

import toour.action.Action;
import toour.post.dao.InquiryDAO;
import toour.post.vo.InquiryVO;
import toour.util.Paging;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class adminInquiryAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pageType = request.getParameter("pageType");
        String viewPath = "admin/admin_Inquiry.jsp";
        if ("inquiryDetails".equals(pageType)) {
            viewPath = "admin/inquiryDetails.jsp";
        }
        if ("inquiry".equals(pageType)) {
            viewPath = "admin/admin_Inquiry.jsp";
        }
        //문의 테이블 총 수 가져옴
        int cnt = InquiryDAO.getInquiryTotalCount();
        //Page 생성
        Paging page = new Paging(10, 5);
        page.setTotalCount(cnt);
        String cPage = request.getParameter("cPage");
        if (cPage == null || cPage.isEmpty() || cPage.equals("null")) {
            page.setNowPage(1);
        } else {
            int nowPage = Integer.parseInt(cPage); //"2" -> 2
            page.setNowPage(nowPage);
            //게시물을 추출할 때 사용되는 begin과 end가 구해지고,
            //startPage와 endPage도 같이 구해졌다.
        }

        //table에 표현될 DB 데이터 값 가져옴, Paging의 begin은 1부터 시작, DB는 0부터 계산하기에 -1 해줘야함
        InquiryVO[] IvoArr = InquiryDAO.getInquiryTotaldata(page.getBegin() - 1, page.getNumPerPage());
        //searchType을 받아 DB 데이터 값 가져옴
        String searchType = request.getParameter("searchType");
        InquiryVO[] cateAr = InquiryDAO.searchCategorydata(searchType);
        request.setAttribute("page", page);
        request.setAttribute("IvoArr", IvoArr);
        request.setAttribute("cateAr", cateAr);

        return viewPath;
    }
}
