package toour.course.action;

import toour.action.Action;
import toour.course.dao.AddCourseDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TotalDeleteAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String course_idx = request.getParameter("course_idx");
        String courseDate_idx = request.getParameter("courseDate_idx");
        System.out.println("deleteCourseDate_idx : " + courseDate_idx);

        if (course_idx != null) {
            AddCourseDAO.totalDeleteCourse(course_idx);
        }
        if (courseDate_idx != null) {
            AddCourseDAO.deleteCourseDate(courseDate_idx);
        }


        return "Controller?type=searchCourse";
    }
}
