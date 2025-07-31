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
    public static MemberVO getMemN(String nickname){
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO mvo = ss.selectOne("member.getN",nickname);
        ss.close();
        return mvo;
    }
}
