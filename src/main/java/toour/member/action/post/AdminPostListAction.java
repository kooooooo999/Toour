package toour.member.action.post;

import toour.member.dao.AdminPostDAO;
import toour.post.vo.PostVO;
import toour.action.Action;
import toour.post.dao.PostDAO;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminPostListAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String category_idx=request.getParameter("category_idx");
        if(category_idx==null)
            category_idx="2";

        int totalCount= AdminPostDAO.getTotalCount(category_idx);
        Paging page = new Paging(10,5);
        page.setTotalCount(totalCount);

        String cPage = request.getParameter("cPage");

        if (cPage == null || cPage.equals("") || cPage.equals("null")) {
            page.setNowPage(1);
        }
        else{
            int nowPage= Integer.parseInt(cPage);
            page.setNowPage(nowPage);
        }

        PostVO[] ar = AdminPostDAO.getnoticeList(category_idx,page.getBegin(),page.getEnd());

        request.setAttribute("category_idx", category_idx);
        request.setAttribute("page",page);
        request.setAttribute("ar",ar);
        request.setAttribute("totalCount",totalCount);
        request.setAttribute("cPage",cPage);
        request.setAttribute("nowPage",page.getNowPage());
        return "admin/admin_post.jsp";
    }
}