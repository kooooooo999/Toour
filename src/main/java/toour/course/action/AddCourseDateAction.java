package toour.course.action;

import toour.action.Action;
import toour.course.dao.AddCourseDAO;
import toour.member.vo.CourseInVO;
import toour.member.vo.MemberVO;
import toour.tripsuggestion.vo.DataVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class AddCourseDateAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int idx = 0;
        Object obj = request.getSession().getAttribute("member");
        String result = null;
        String date = request.getParameter("date");
        String course_idx = request.getParameter("course_idx");
        String date_title = request.getParameter("date_title");
        MemberVO mvo = null;
        if (obj != null) {
            mvo = (MemberVO) obj;
        }
        List<DataVO> list = mvo.getCourseList();

        try {
            result = AddCourseDAO.courseDateAdd(date, course_idx, date_title, list);
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("course_idx", course_idx);
        return "Controller?type=searchCourseDate";
    }
}
