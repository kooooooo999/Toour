package toour.member.action;

import toour.post.vo.PostVO;
import toour.action.Action;
import toour.post.dao.PostDAO;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminNoticeSearchAction implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        String category_idx = request.getParameter("category_idx");
        if (category_idx == null)
            category_idx = "1";
        int totalCount = PostDAO.getTotalCount(category_idx);

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

        if(ar!=null &&ar.length>0)
            System.out.println("검색 결과 첫 번째 항목: " + ar[0]);
        else
            System.out.println("검색결과가 없습니다.");
        System.out.println(ar[0]);

        request.setAttribute("page",page);
        request.setAttribute("ar",ar);
        request.setAttribute("category_idx",category_idx);
        request.setAttribute("totalCount",totalCount);
        request.setAttribute("searchType",searchType);
        request.setAttribute("searchValue",searchValue);
        request.setAttribute("nowPage",page.getNowPage());
        return "admin/admin_notice.jsp";
    }
}
