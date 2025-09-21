package toour.post.action;

import toour.action.Action;
import toour.post.dao.InquiryDAO;
import toour.post.dao.PostDAO;
import toour.post.vo.PostVO;
import toour.util.Paging;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class InquirySearchAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        String category = request.getParameter("category");

        int totalCount = InquiryDAO.getSearchTotalCount(searchType,searchValue);

        Paging page = new Paging(10,5);

        page.setTotalCount(totalCount);

        String cPage = request.getParameter("cPage");

        if (cPage == null)
            page.setNowPage(1);
        else{
            int nowPage= Integer.parseInt(cPage);
            page.setNowPage(nowPage);
        }

        PostVO[] ar = PostDAO.search(searchType,searchValue, page.getBegin(),page.getEnd());

        if(ar!=null &&ar.length>0) {
            System.out.println("검색 결과 첫 번째 항목: " + ar[0]);
        } else {
            System.out.println("검색결과가 없습니다.");
        }

        request.setAttribute("inquiryPage",page);
        request.setAttribute("inquiryAr",ar);
        request.setAttribute("category",category);
        request.setAttribute("inquiryTotalCount",totalCount);
        request.setAttribute("inquirySearchType",searchType);
        request.setAttribute("inquirySearchValue",searchValue);
        request.setAttribute("inquiryNowPage",page.getNowPage());

        return "member/myPage.jsp";
    }
}
