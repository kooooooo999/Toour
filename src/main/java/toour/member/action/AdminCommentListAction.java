package toour.member.action;

import toour.action.Action;
import toour.member.dao.AdminPostDAO;
import toour.post.vo.PostVO;
import toour.post.dao.PostDAO;
import toour.post.dao.ReportDAO;
import toour.post.vo.CommentVO;
import toour.post.vo.ReportVO;
import toour.util.Paging;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static toour.post.dao.ReportDAO.TotalCount;

public class AdminCommentListAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String comment_idx = request.getParameter("comment_idx");

        int totalCount= AdminPostDAO.getcommentTotalCount();
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

        PostVO[] ar = AdminPostDAO.getcommentList(comment_idx,page.getBegin(),page.getEnd());

        request.setAttribute("page",page);
        request.setAttribute("ar",ar);
        request.setAttribute("totalCount",totalCount);
        request.setAttribute("cPage",cPage);
        request.setAttribute("nowPage",page.getNowPage());
        return "admin/admin_post.jsp";
    }

}