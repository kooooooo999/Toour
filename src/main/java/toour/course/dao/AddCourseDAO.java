package toour.course.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.member.vo.CourseVO;

import java.util.List;

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
}
