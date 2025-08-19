package toour.course.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.member.vo.CourseDateVO;
import toour.member.vo.CourseVO;

import java.util.List;

public class CourseDateDAO {

    public static CourseDateVO[] searchCourseDate(String course_idx) {
        CourseDateVO[] date_ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<CourseDateVO> list = ss.selectList("course.getCourseDate", course_idx);
        System.out.println(course_idx);
        System.out.println(list.size());

        if (list != null && !list.isEmpty()) {
            date_ar = new CourseDateVO[list.size()];
            list.toArray(date_ar);
        }

        ss.close();
        return date_ar;
    }
}
