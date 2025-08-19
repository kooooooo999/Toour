package toour.course.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.member.vo.CourseVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AddCourseDAO {

    public static CourseVO[] searchCourse(String member_idx) {
        CourseVO[] course_ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<CourseVO> list = ss.selectList("course.get", member_idx);
        if (list != null) {
            course_ar = new CourseVO[list.size()];
            list.toArray(course_ar);
        }

        ss.close();
        return course_ar;
    }

    public static int courseAdd(String member_idx, String course_name, String course_summary) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        Map<String, String> map = new HashMap<>();
        map.put("member_idx", member_idx);
        map.put("course_name", course_name);
        map.put("course_summary", course_summary);

        cnt = ss.insert("course.addCourse", map);

        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
        return cnt;
    }
}
