package toour.login.dao;

import mybatis.service.FactoryService;
import toour.member.vo.MemberVO;
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

    public static MemberVO getMemE(String email){
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO mvo = ss.selectOne("member.getE",email);
        ss.close();
        return mvo;
    }

    public static void updateLastLogin(String member_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        ss.update("member.updateLastLogin", member_idx);
    }

    public static MemberVO getMemberByLoginType(String login_type,String member_email){
        SqlSession ss = FactoryService.getFactory().openSession();
        //입력된 값을 memberVO로 만들어 parameter 만들기
        MemberVO member = new MemberVO();
        member.setLogin_type(login_type);
        member.setMember_email(member_email);
        //resultType이  MemberVO라 이렇게 해줌
        MemberVO mvo = ss.selectOne("member.getByLoginType", member);
        ss.close();
        return mvo;
    }

}
