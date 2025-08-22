package toour.course.action;

import toour.action.Action;
import toour.course.dao.AddCourseDAO;
import toour.member.vo.CourseVO;
import toour.member.vo.MemberVO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SearchCourseAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 내 여행 띄우기

        System.out.println(request.getParameter("number"));
        Object obj = request.getSession().getAttribute("member");
        MemberVO mvo = null;

        if (obj != null) {
            mvo = (MemberVO) obj;
        }

        String member_idx = mvo.getMember_idx();

        CourseVO[] course_ar = AddCourseDAO.searchCourse(member_idx);

        request.setAttribute("course_ar", course_ar);
        request.setAttribute("member_idx", member_idx);

        return "courseListReturn.jsp";
    }
}
