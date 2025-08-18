package toour.member.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.member.vo.CourseVO;

import java.util.List;

public class CourseDAO {

    public static List<CourseVO> getCourseVO(String member_idx){

        SqlSession ss = FactoryService.getFactory().openSession();
        List<CourseVO> cvo_list = ss.selectList("course.get",member_idx);
        ss.close();
        return cvo_list;
    }
}
