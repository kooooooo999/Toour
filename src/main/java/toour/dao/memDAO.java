package toour.dao;

import mybatis.service.FactoryService;
import mybatis.vo.MemberVO;
import org.apache.ibatis.session.SqlSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class memDAO {
    //총회원수 가지고 오기
    public static int getTotalMemCount(){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("mem.totalMemCount");
        ss.close();
        return cnt;
    }

    public static MemberVO[] getmemList(String member_idx, int begin, int end) {
        MemberVO[] ar = null;
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("member_idx",member_idx);
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









}
