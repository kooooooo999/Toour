package toour.course.action;

import toour.action.Action;
import toour.course.dao.CourseDateDAO;
import toour.member.vo.CourseDateVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SearchCourseDateAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String course_idx = request.getParameter("course_idx");

        CourseDateVO[] date_ar = CourseDateDAO.searchCourseDate(course_idx);

        request.setAttribute("course_idx", course_idx);
        request.setAttribute("date_ar", date_ar);

        return "courseDateReturn.jsp";
    }
}
