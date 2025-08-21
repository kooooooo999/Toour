package toour.course.action;

import toour.action.Action;
import toour.course.dao.AddCourseDAO;
import toour.member.vo.MemberVO;
import toour.tripsuggestion.vo.DataVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class CourseDeleteAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Object obj = request.getSession().getAttribute("member");
        int cnt = 0;
        int cnt2 = 0;

        MemberVO mvo = null;
        if (obj != null) {
            mvo = (MemberVO) obj;
        }
        List<DataVO> list = mvo.getCourseList();

        String courseDate_idx = request.getParameter("courseDate_idx");
        System.out.println("CourseDeleteAction : " + courseDate_idx);
        cnt = AddCourseDAO.deleteCourse(courseDate_idx);
        cnt2 = AddCourseDAO.addCourseIn(courseDate_idx, list);

        request.setAttribute("courseDate_idx", courseDate_idx);

        return "";
    }
}
