package toour.member.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.member.vo.CourseVO;

import java.util.List;

public class CourseDAO {

    public static CourseVO[] getCourseVO(String member_idx){
        CourseVO[] cvo_ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<CourseVO> cvo_list = ss.selectList("course.get",member_idx);
        if(cvo_list!=null) {
            cvo_ar = new CourseVO[cvo_list.size()];
            cvo_list.toArray(cvo_ar);
        }
        return cvo_ar;
    }
}
