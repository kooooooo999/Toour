package toour.dao;

import mybatis.service.FactoryService;
import mybatis.vo.MemberVO;
import org.apache.ibatis.session.SqlSession;


public class MemberDAO {
    public static int addMem(MemberVO mvo){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt =  ss.insert("member.add",mvo);
        if(cnt>0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

        return cnt;
    }
    public static MemberVO getMem(String id){
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO mvo = ss.selectOne("member.get",id);
        ss.close();
        return mvo;
    }

    public static MemberVO getMemIdx(String member_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO mvo = ss.selectOne("post.list", member_idx);
        ss.close();
        return mvo;
    }
}
