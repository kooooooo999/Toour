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
import java.util.ArrayList;
import java.util.List;

public class MyCourseDayAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String courseDate_idx = request.getParameter("courseDate_idx");
        CourseInVO[] cvo_ar = AddCourseDAO.myDayList(courseDate_idx);
        List<DataVO> list = new ArrayList<>();

        Object obj = request.getSession().getAttribute("member");
        MemberVO mvo = null;
        if (obj != null) {
            mvo = (MemberVO) obj;
        }

        if (cvo_ar != null) {
            for (CourseInVO cvo : cvo_ar) {
                DataVO dvo = new DataVO();
                dvo.setContentId(cvo.getContentId());
                dvo.setContentTypeId(cvo.getContentTypeId());
                dvo.setTitle(cvo.getTitle());
                dvo.setAddr1(cvo.getAddr1());
                dvo.setMapx(cvo.getMapx());
                dvo.setMapy(cvo.getMapy());

                list.add(dvo);
            }
        }

        mvo.setCourseList(list);
        request.setAttribute("myCourse", "myCourse");
        request.setAttribute("courseDate_idx", courseDate_idx);
        return "Controller?type=searchResult";
    }
}
