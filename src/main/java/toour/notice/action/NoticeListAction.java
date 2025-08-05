package toour.notice.action;

import toour.post.vo.PostVO;
import toour.action.Action;
import toour.post.dao.PostDAO;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NoticeListAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String category_idx=request.getParameter("category_idx");
        if(category_idx==null)
            category_idx="1";
        int totalCount= PostDAO.getTotalCount(category_idx);
        Paging page = new Paging(10,5);
        page.setTotalCount(totalCount);

        String cPage = request.getParameter("cPage");

        if (cPage == null) {
            page.setNowPage(1);
        }
        else{
            int nowPage= Integer.parseInt(cPage);
            page.setNowPage(nowPage);
        }

        PostVO[] ar = PostDAO.getList(category_idx,page.getBegin(),page.getEnd());

        
        request.setAttribute("page",page);
        request.setAttribute("ar",ar);
        request.setAttribute("totalCount",totalCount);
        request.setAttribute("cPage",cPage);
        request.setAttribute("nowPage",page.getNowPage());
        return "notice/noticeList.jsp";
    }
}
