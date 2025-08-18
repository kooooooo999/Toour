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

    public static void updateMyInfo(MemberVO mvo){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("member.changeMyInfo", mvo);

        if(cnt >0)
            ss.commit();
        else
            ss.rollback();
        ss.close();

    }



    //카카오 로그인?
    public static MemberVO getKakaoMember(String login_type, String account_email) {
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO member = new MemberVO();
        member.setLogin_type(login_type);
        member.setMember_email(account_email);
        MemberVO mvo = ss.selectOne("member.getKakaoLogin",member);
        ss.close();
        return mvo;
    }

    public static MemberVO getNaverMember(String member_email) {
        SqlSession ss = FactoryService.getFactory().openSession();
        MemberVO mvo = ss.selectOne("member.getNaverLogin",member_email);
        ss.close();
        return mvo;
    }




}
