package toour.course.action;

import toour.action.Action;
import toour.course.dao.AddCourseDAO;
import toour.member.vo.CourseVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddCourseListAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int idx = 0;
        String member_idx = request.getParameter("member_idx");
        String course_name = request.getParameter("course_name");
        String course_summary = request.getParameter("course_summary");

        try {
            idx = AddCourseDAO.courseAdd(member_idx, course_name, course_summary);
        } catch (Exception e) {
            e.printStackTrace();
        }


        return "Controller?type=searchCourse";
    }
}
