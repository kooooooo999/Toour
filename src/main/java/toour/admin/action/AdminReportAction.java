package toour.admin.action;

import toour.action.Action;
import toour.post.dao.ReportDAO;
import toour.post.vo.ReportVO;
import toour.util.Paging;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static toour.post.dao.ReportDAO.TotalCount;

public class AdminReportAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ReportVO[] rvo = ReportDAO.getReport();

        int totalCount = ReportDAO.getReportCount();
        Paging page = new Paging(10,5);
        page.setTotalCount(totalCount);

        String cPage = request.getParameter("cPage");
        if (cPage == null || cPage.equals("")) {
            page.setNowPage(1);
        }else {
            int nowPage = Integer.parseInt(cPage);
            page.setNowPage(nowPage);
        }


        request.setAttribute("totalCount", totalCount);
        request.setAttribute("rvo", rvo);
        request.setAttribute("page",page);
        request.setAttribute("cPage",cPage);
        request.setAttribute("nowPage",page.getNowPage());
        request.setAttribute("TotalCount",TotalCount());




        return "admin/admin_report.jsp";
    }
}
