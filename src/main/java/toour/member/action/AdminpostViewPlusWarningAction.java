package toour.member.action;

import toour.action.Action;
import toour.member.dao.AdminPostDAO;
import toour.post.dao.ReportDAO;
import toour.post.vo.ReportVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class AdminpostViewPlusWarningAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String report_idx = request.getParameter("report_idx");
        String post_idx = request.getParameter("post_idx");

        if (report_idx == null || report_idx.trim().isEmpty()) {
            return "error.jsp";
        }

        int reportstatus = ReportDAO.reportstatus(report_idx);
        ReportVO rvo = AdminPostDAO.getreportidx(report_idx);

        int pluswarning = AdminPostDAO.pluswarning(report_idx);
        List<Map<String, Object>> commentListWithReports = ReportDAO.getCommentListWithReports(post_idx);



        System.out.println("report_idx:::::::::::"+report_idx);

        request.setAttribute("pluswarning",pluswarning);
        request.setAttribute("commentList", commentListWithReports);
        request.setAttribute("rvo",rvo);
        request.setAttribute("reportstatus",reportstatus);

        return "admin/admin_post_view.jsp";
    }
}
