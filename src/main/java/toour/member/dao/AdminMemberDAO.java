package toour.member.dao;

import mybatis.service.FactoryService;
import toour.member.vo.MemberVO;
import org.apache.ibatis.session.SqlSession;
import toour.post.vo.PostVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminMemberDAO {
    //총회원수 가지고 오기
    public static int getTotalMemCount(){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("mem.totalMemCount");
        ss.close();
        return cnt;
    }

//    회원수 가지고 오기
    public static int MemCount(){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("mem.MemCount");
        ss.close();
        return cnt;
    }



//    휴면회원수 가지고 오기
    public static int DormantMemCount(){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("mem.DormantMemCount");
        ss.close();
        return cnt;
    }

//    탈퇴회원수 가지고 오기
    public static int DeactivatedMemCount(){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("mem.DeactivatedMemCount");
        ss.close();
        return cnt;
    }
//강퇴회원수 가지고 오기
    public static int BannedMemCount(){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("mem.BannedMemCount");
        ss.close();
        return cnt;
    }

//    일주일치 방문자 수 구하기
    public static int RecentVisitMem(){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("mem.RecentVisitMem");
        ss.close();
        return cnt;
    }



    public static MemberVO[] getmemList(int begin, int end) {
        MemberVO[] ar = null;
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("begin",begin);
        map.put("end",end);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<MemberVO> list = ss.selectList("mem.mem_list", map);
        if(list.size()>0&& list!=null){
            ar= new MemberVO[list.size()];
            list.toArray(ar);
        }
        ss.close();

        return ar;
    }

    //회원정보 가지고 오기
    public static MemberVO view(String member_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO vo = ss.selectOne("mem.mem_view", member_idx); //하나만 받아서 list 안씀

        ss.close();
        return vo;
    }

    //회원정보 수정
    public static int Re(String member_idx, String member_name, String member_nickname, String member_password, String member_email, String member_id){
        int cnt = 0;
        Map<String, String> map = new HashMap<>();
        System.out.println(member_idx);
        System.out.println(member_name);
        System.out.println(member_nickname);
        System.out.println(member_password);
        System.out.println(member_email);
        System.out.println(member_id);

        map.put("member_idx", member_idx);
        map.put("member_name", member_name);
        map.put("member_nickname", member_nickname);
        map.put("member_password", member_password);
        map.put("member_email", member_email);
        map.put("member_id", member_id);



        SqlSession ss = FactoryService.getFactory().openSession();
        cnt = ss.update("mem.mem_edit", map);
        if(cnt > 0)
            ss.commit();
        else
            ss.rollback();
        ss.close();
        return cnt;
    }

    //회원정보 삭제/탈퇴
    public static int delMem(List<String> memberIdxlist){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("mem.mem_del", memberIdxlist);
        if(cnt > 0){
            ss.commit();
        }
        else {
            ss.rollback();
        }
        ss.close();
        return cnt;
    }

    // 게시물에서 검색결과 수를 반환
    public static int getSearchTotalCount(String searchType,String searchValue){
        SqlSession ss = FactoryService.getFactory().openSession();
        Map<String, String> map = new HashMap<>();
        if(searchType!=null)
            map.put("searchType", searchType);
        if(searchValue!=null)
            map.put("searchValue", searchValue);

        int cnt = ss.selectOne("mem.searchTotalCount",map);
        ss.close();
        return cnt;
    }

    //회원정보 검색
    public static MemberVO[] search(String searchType, String searchValue, int begin, int end){
        MemberVO[] ar = null;
        Map<String,Object> map = new HashMap<String,Object>();
        if(searchType!=null)
            map.put("searchType", searchType);
        if(searchValue!=null)
            map.put("searchValue", searchValue);
        map.put("begin",begin);
        map.put("end",end);

//        System.out.println(searchType);
//        System.out.println(searchValue);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<MemberVO> list = ss.selectList("mem.mem_search",map);
        if(list!=null&&list.size()>0){
            ar= new MemberVO[list.size()];
            list.toArray(ar);
        } else {
            // 검색 결과가 없을 때 빈 배열을 반환하도록 수정
            ar = new MemberVO[0];
        }
//        System.out.println("검색타입: " + searchType);
//        System.out.println("검색값: " + searchValue);
//        System.out.println("검색결과 수: " + (list != null ? list.size() : "null"));

//        System.out.println(" searchType = [" + searchType + "]");
//        System.out.println(" searchValue = [" + searchValue + "]");

        ss.close();
        return ar;
    }

}
