package toour.post.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.Map;

public class RecommendDAO {

    public static int recommendInsert(String member_idx,String post_idx){
        Map<String,Object> map = new HashMap<>();
        map.put("member_idx",member_idx);
        map.put("post_idx",post_idx);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("recommend.recommendInsert",map);
        if(cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();

        return cnt;
    }

    public static int deleteRecommend(String member_idx,String post_idx){
        Map<String,Object> map = new HashMap<>();
        map.put("member_idx",member_idx);
        map.put("post_idx",post_idx);
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.delete("recommend.deleteRecommend",map);
        if(cnt > 0) {
            ss.commit();
        }else  {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }



}
