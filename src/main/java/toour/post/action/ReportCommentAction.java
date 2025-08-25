package toour.post.action;

import toour.action.Action;
import toour.post.dao.PostDAO;
import toour.post.dao.ReportDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ReportCommentAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String reporter_idx = request.getParameter("reporter_idx");
        String post_idx = request.getParameter("post_idx");
        String reported_idx = request.getParameter("reported_idx");
        String report_content = request.getParameter("reason");
        String comment_idx = request.getParameter("comment_idx");


        int cnt = ReportDAO.insertCommentReport(reporter_idx,reported_idx,post_idx,comment_idx,report_content);
        System.out.println("reportCommentAction cnt"+cnt);





        return "Controller?type=list";
    }
}
