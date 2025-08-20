package toour.member.dao;

import mybatis.service.FactoryService;
import toour.member.vo.MemberVO;
import toour.post.vo.PostVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminNoticeDAO {
    // 총 게시물의 수를 반환
    public static int getTotalCount(String category_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("adminnotice.totalCount",category_idx);
        ss.close();
        return cnt;
    }

    // 기본키(고유번호)를 인자로 하여 게시물 가져오기
    public static PostVO getPost(String post_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        PostVO vo = ss.selectOne("adminnotice.getPost", post_idx);
        System.out.println("vo"+vo);

        ss.close();
        return vo;
    }

    //게시물 멤버idx가져오기
    public static MemberVO getNoticeMemberIdx(String post_idx){
//        System.out.println("here is getPostMemberIdx");
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO postMemberIdx = ss.selectOne("adminnotice.getPostMember",post_idx);
        System.out.println("getNoticeMemberIdx 결과: " + postMemberIdx);
        ss.close();
        return postMemberIdx;
    }

    // 게시물에서 검색결과 수를 반환
    public static int getSearchTotalCount(String searchType,String searchValue){
        SqlSession ss = FactoryService.getFactory().openSession();
        Map<String, String> map = new HashMap<>();
        if(searchType!=null)
            map.put("searchType", searchType);
        if(searchValue!=null)
            map.put("searchValue", searchValue);

        int cnt = ss.selectOne("adminnotice.searchTotalCount",map);
        ss.close();
        return cnt;
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
        List<PostVO> list = ss.selectList("adminnotice.search",map);
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
        int cnt = ss.update("adminnotice.del", post_idx);
        if(cnt > 0){
            ss.commit();
        }else{
            ss.rollback();
        }
        ss.close();
        return cnt;

    }


    // 목록 반환
    public static PostVO[] getnoticeList(String category_idx, int begin, int end){
        PostVO[] ar = null;

        Map<String, Object> map = new HashMap<>();
        map.put("category_idx", category_idx);
        map.put("begin", begin);
        map.put("end", end);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<PostVO> list = ss.selectList("adminnotice.list", map);
        if(list != null && list.size()>0){
            ar = new PostVO[list.size()];
            list.toArray(ar); // list에 있는 모든 항목들을 배열 ar에 복사한다.
        }
        ss.close();
        return ar;
    }

    // 저장 +++
    public static String postadd(String post_title, String post_content, String member_idx,
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
        cnt = ss.insert("adminnotice.add", map);
        String post_idx = String.valueOf(map.get("post_idx"));
//        System.out.println("DAO:"+post_idx);
        if(cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return post_idx;
    }

    //파일 저장
    public static int fileadd(String post_idx, String file_name_original,String file_name_stored, String file_s3_url, String file_size,String file_type) {
        int cnt = 0;
        Map<String, String> map = new HashMap<>();
        map.put("post_idx", post_idx);
        map.put("file_name_original", file_name_original);
        map.put("file_name_stored", file_name_stored);
        map.put("file_s3_url", file_s3_url);
        map.put("file_size", file_size);
        map.put("file_type", file_type);

        SqlSession ss = FactoryService.getFactory().openSession();
        cnt = ss.insert("adminnotice.add_file", map);

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


        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("adminnotice.edit", map);
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
            int filenum = ss.selectOne("adminnotice.file_num", post_idx);

            if(filenum > 0){
                //파일이 있음 - update 해줌
                filecnt = ss.update("adminnotice.edit_file", filemap);
            }
            else {
                //파일이 없음 - insert 해줌
                filecnt = ss.insert("adminnotice.add_file", filemap);
            }


            if (filecnt > 0)
                ss.commit();
            else
                ss.rollback();
            ss.close();

        }
        return filecnt;
    }
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

