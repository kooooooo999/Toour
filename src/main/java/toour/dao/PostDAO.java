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


    // 목록 반환
    public static PostVO[] getgetList(String category_idx, int begin, int end){
        PostVO[] ar = null;

        Map<String, Object> map = new HashMap<>();
        map.put("category_idx", category_idx);
        map.put("begin", category_idx);
        map.put("end", category_idx);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<PostVO> list = ss.selectList("post.list", map);
        if(list != null && list.size()>0){
            ar = new PostVO[list.size()];
            list.toArray(ar); // list에 있는 모든 항목들을 배열 ar에 복사한다.
        }
        ss.close();
        return ar;
    }
    // 저장 +++
    public static int add(String post_title, String post_content, String member_idx,
                          String category_idx){
        int cnt = 0;

        Map<String, String> map = new HashMap<>();
        map.put("post_title", post_title);
        map.put("post_content", post_content);
        map.put("member_idx", member_idx);
        map.put("category_idx", category_idx);

        SqlSession ss = FactoryService.getFactory().openSession();
        cnt = ss.insert("post.add", map);
        if(cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return cnt;
    }

    // 기본키(고유번호)를 인자로 하여 게시물 가져오기
    public static PostVO getPost(String post_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        PostVO vo = ss.selectOne("post.getpost", post_idx);
        ss.close();
        return vo;
    }


}
