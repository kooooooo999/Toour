package toour.post.action;

import toour.action.Action;
import toour.login.dao.MemberDAO;
import toour.member.vo.MemberVO;
import toour.post.dao.ReportDAO;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ReportAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        String reporter_idx = request.getParameter("reporter_idx");
        String post_idx = request.getParameter("post_idx");
        String reported_idx = request.getParameter("reported_idx");
        String report_content = request.getParameter("reason");


        int cnt = ReportDAO.insertReport(reporter_idx,reported_idx,post_idx,report_content);
        System.out.println("reportAction cnt"+cnt);





                return "Controller?type=list";
    }
}
