package toour.notice.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.notice.vo.PostVO;

import java.util.List;

public class NoticeDAO {
    public static List<toour.notice.vo.PostVO> selectLatestNotice(int limit){
        SqlSession ss = FactoryService.getFactory().openSession();
        List<PostVO> list = ss.selectList("notice.selectLatestNotice", limit);
        ss.close();
        return list;
    }
}

