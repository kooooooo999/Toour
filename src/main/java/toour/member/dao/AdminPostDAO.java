package toour.member.dao;

import mybatis.service.FactoryService;
import toour.post.vo.PostVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminPostDAO {
    // 총 게시물의 수를 반환
    public static int getTotalCount(String category_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("adminpost.totalCount",category_idx);
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
        List<PostVO> list = ss.selectList("adminpost.list", map);
        if(list.size()>0&& list!=null){
            ar= new PostVO[list.size()];
            list.toArray(ar);
        }
        ss.close();

        return ar;
    }


    // 기본키(고유번호)를 인자로 하여 게시물 가져오기
    public static PostVO getPost(String post_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        PostVO vo = ss.selectOne("adminpost.getPost", post_idx);
        ss.close();
        return vo;
    }

    public static PostVO[] search(String searchType,String searchValue,int begin,int end){
        PostVO[] ar = null;
        Map<String,Object> map = new HashMap<String,Object>();
        if(searchType!=null)
            map.put("searchType", searchType);
        if(searchValue!=null)
            map.put("searchValue", searchValue);
        map.put("begin",begin);
        map.put("end",end);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<PostVO> list = ss.selectList("adminpost.search",map);
        if(list!=null&&list.size()>0){
            ar= new PostVO[list.size()];
            list.toArray(ar);
        }
        if(list!=null&&list.size()>0){
            ar= new PostVO[list.size()];
            list.toArray(ar);
        } else {
            // 검색 결과가 없을 때 빈 배열을 반환하도록 수정
            ar = new PostVO[0];
        }
        ss.close();
        return ar;
    }


    // 삭제
    public static int delnotice(String post_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("adminpost.del", post_idx);
        if(cnt > 0){
            ss.commit();
        }else{
            ss.rollback();
        }
        ss.close();
        return cnt;

    }


    // 목록 반환
    public static PostVO[] getgetList(String category_idx, int begin, int end){
        PostVO[] ar = null;

        Map<String, Object> map = new HashMap<>();
        map.put("category_idx", category_idx);
        map.put("begin", category_idx);
        map.put("end", category_idx);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<PostVO> list = ss.selectList("adminpost.list", map);
        if(list != null && list.size()>0){
            ar = new PostVO[list.size()];
            list.toArray(ar); // list에 있는 모든 항목들을 배열 ar에 복사한다.
        }
        ss.close();
        return ar;
    }
    // 저장 +++
    public static int postadd(String post_title, String post_content, String member_idx,
                          String category_idx, String post_views, String post_status){
        int cnt = 0;

        Map<String, String> map = new HashMap<>();
        map.put("post_title", post_title);
        map.put("post_content", post_content);
        map.put("member_idx", member_idx);
        map.put("category_idx", category_idx);
        map.put("post_views", post_views);
        map.put("post_status", post_status);



        SqlSession ss = FactoryService.getFactory().openSession();
        cnt = ss.insert("adminpost.add", map);
        if(cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return cnt;
    }



    // 수정
    public static int edit(String post_idx, String post_title, String post_content,
                           String file_name_stored, String file_name_original, String ip){
        Map<String, String> map = new HashMap<>();
        map.put("post_idx", post_idx);
        map.put("post_title", post_title);
        map.put("post_content", post_content);

        if(file_name_stored != null){
            map.put("file_name_stored", file_name_stored);
            map.put("file_name_original", file_name_original);
        }
        map.put("ip",ip);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("adminpost.edit", map);
        if(cnt > 0)
            ss.commit();
        else ss.rollback();
        ss.close();

        return cnt;
    }

//    // 조회수 증가
//    public static int post_views(String post_idx){
//        SqlSession ss = FactoryService.getFactory().openSession();
//        int cnt = ss.update("post.post_views", post_idx);
//        if(cnt > 0)
//            ss.commit();
//        else ss.rollback();
//        ss.close();
//        return cnt;
//    }
}
