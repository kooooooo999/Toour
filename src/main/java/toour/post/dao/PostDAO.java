package toour.post.dao;

import mybatis.service.FactoryService;
import toour.member.vo.MemberVO;
import toour.post.vo.CommentVO;
import toour.post.vo.PostVO;
import org.apache.ibatis.session.SqlSession;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PostDAO {
    // 총 게시물의 수를 반환
    public static int getTotalCount(String category_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("post.totalCount",category_idx);
        ss.close();
        return cnt;
    }

    // 내가 쓴 총 게시물의 수를 반환
    public static int getMyTotalCount(String member_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("post.myTotalCount",member_idx);
        ss.close();
        return cnt;
    }

    // 내가 쓴 총 게시물에서 검색결과 수를 반환
    public static int getMySearchTotalCount(String searchType,String searchValue,String member_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        Map<String, String> map = new HashMap<>();
        if(searchType!=null)
            map.put("searchType", searchType);
        if(searchValue!=null)
            map.put("searchValue", searchValue);
        map.put("member_idx", member_idx);

        int cnt = ss.selectOne("post.mySearchTotalCount",map);
        ss.close();
        return cnt;
    }


    //글쓰기 목록 보기
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



    // 기본키(고유번호)를 인자로 하여 게시물 가져오기
    public static PostVO getPost(String post_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        PostVO vo = ss.selectOne("post.getPost", post_idx);
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
        List<PostVO> list = ss.selectList("post.search",map);
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

    public static PostVO[] mysearch(String searchType,String searchValue,int begin,int end,String member_idx){
        PostVO[] ar = null;
        Map<String,Object> map = new HashMap<String,Object>();
        if(searchType!=null)
            map.put("searchType", searchType);
        if(searchValue!=null)
            map.put("searchValue", searchValue);
        map.put("begin",begin);
        map.put("end",end);
        map.put("member_idx", member_idx);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<PostVO> list = ss.selectList("post.mysearch",map);
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


    //조회수 증가
    public static int hit(String post_idx){
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();
        cnt = ss.update("post.hit", post_idx);
        if(cnt>0)
            ss.commit();
        else
            ss.rollback();
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
        List<PostVO> list = ss.selectList("post.list", map);
        if(list != null && list.size()>0){
            ar = new PostVO[list.size()];
            list.toArray(ar); // list에 있는 모든 항목들을 배열 ar에 복사한다.
        }
        ss.close();
        return ar;
    }

    public static PostVO[] getMyList(String member_idx, int begin, int end){
        PostVO[] ar = null;

        Map<String, Object> map = new HashMap<>();
        map.put("member_idx", member_idx);
        map.put("begin", begin);
        map.put("end", end);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<PostVO> list = ss.selectList("post.mylist", map);
        if(list != null && list.size()>0){
            ar = new PostVO[list.size()];
            list.toArray(ar); // list에 있는 모든 항목들을 배열 ar에 복사한다.
        }
        ss.close();
        return ar;
    }

    // 저장 +++
    public static int add(String post_title, String post_content, String member_idx,
                          String category_idx, String post_views, String post_likes, String post_comments_count,
                          String post_status, String post_created_at, String post_star){

        SqlSession ss = FactoryService.getFactory().openSession();

        Map<String, Object> map = new HashMap<>();
        map.put("post_title", post_title);
        map.put("post_content", post_content);
        map.put("member_idx", member_idx);
        map.put("category_idx", category_idx);

        map.put("post_views", "0");
        map.put("post_likes", "0");
        map.put("post_comments_count", "0");
        map.put("post_status", "0");
        map.put("post_star", "0");

        int cnt = ss.insert("post.add", map);
        // MyBatis가 반환한 객체가 BigInteger 타입일 경우
        Object generatedKey = map.get("post_idx");

        int generatedPostIdx = 0;
        if (generatedKey instanceof BigInteger) {
            generatedPostIdx = ((BigInteger) generatedKey).intValue();
        } else if (generatedKey instanceof Integer) {
            generatedPostIdx = (Integer) generatedKey;
        } else if (generatedKey instanceof Long) {
            generatedPostIdx = ((Long) generatedKey).intValue();
        }

        if(cnt > 0) {
            ss.commit();
        }
        else {
            ss.rollback();
        }
        ss.close();

        return generatedPostIdx;
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


        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("post.edit", map);
        if(cnt > 0)
            ss.commit();
        else ss.rollback();
        ss.close();

        return cnt;
    }
    public static int fileedit(String post_idx,String file_name_original,String file_name_stored,String file_size,String file_type ) {
        int filecnt = 0;
        if (file_name_stored != null && file_name_original != null) {
            Map<String, String> filemap = new HashMap<>();

            filemap.put("post_idx", post_idx);
            filemap.put("file_name_stored", file_name_stored);
            filemap.put("file_name_original", file_name_original);
            filemap.put("file_size", file_size);
            filemap.put("file_type", file_type);

            SqlSession ss = FactoryService.getFactory().openSession();
            int filenum = ss.selectOne("file.file_num", post_idx);

            if(filenum > 0){
                //파일이 있음 - update 해줌
                filecnt = ss.update("file.edit_file", filemap);
            }
            else {
                //파일이 없음 - insert 해줌
                filecnt = ss.insert("file.add_file", filemap);
            }


            if (filecnt > 0)
                ss.commit();
            else
                ss.rollback();
            ss.close();

        }
        return filecnt;
    }
    // 조회수 증가
    public static int post_views(String post_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("post.post_views", post_idx);
        if(cnt > 0)
            ss.commit();
        else ss.rollback();
        ss.close();
        return cnt;
    }

    //게시물 식별자 가져오기
    public static String getPostIdx(String post_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        String postIdx = ss.selectOne("post.getPostIdx",post_idx);
        ss.close();
        return postIdx;

    }
    //게시물 멤버idx가져오기
    public static MemberVO getPostMemberIdx(String post_idx){
        System.out.println("here is getPostMemberIdx");
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO postMemberIdx = ss.selectOne("post.getPostMember",post_idx);
        ss.close();
        return postMemberIdx;
    }



    //댓글 쓰기
    public static int insertComment(String post_idx,String member_idx,String comment_content){

        Map<String, String> map = new HashMap<>();
        map.put("post_idx", post_idx);
        map.put("member_idx", member_idx);
        map.put("comment_content", comment_content);
        System.out.println("comment_content:"+comment_content);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("post.insertComment", map);

        if(cnt > 0)
            ss.commit();
        else ss.rollback();
        ss.close();
        return cnt;
    }

    public static CommentVO[] getCommentList(String post_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        CommentVO[] comment =null;
        List<CommentVO> list = ss.selectList("post.getComment",post_idx);
        if(list.size()>0){
            comment = new CommentVO[list.size()];
            list.toArray(comment);
        }
        ss.close();
        return comment;
    }



}

