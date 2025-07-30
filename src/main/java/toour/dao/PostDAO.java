package toour.dao;

import mybatis.service.FactoryService;
import mybatis.vo.PostVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PostDAO {


    public static int getTotalCount(String category_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("post.totalCount", category_idx);
        ss.close();
        return cnt;
    }


    public static PostVO[] getList(String category_idx, int begin, int end ){
        PostVO[] ar = null;
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("category_idx",category_idx);
        map.put("begin",begin);
        map.put("end",end);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<PostVO> list = ss.selectList("post.list", map);
        if(list.size()>0&& list!=null){
            ar= new PostVO[list.size()];
            list.toArray(ar);
        }
        ss.close();

        return ar;
    }
}
