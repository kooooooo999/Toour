package toour.login.dao;

import mybatis.service.FactoryService;
import toour.member.vo.MemberVO;
import org.apache.ibatis.session.SqlSession;


public class MemberDAO {
    public static int addMem(MemberVO mvo) {
        int cnt = 0;
        try (SqlSession ss = FactoryService.getFactory().openSession()) {
            cnt = ss.insert("member.add", mvo);
            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
        } catch (Exception e) {
            e.printStackTrace(); // 로깅 권장
        }
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

    public static int  updateLastLogin(String member_idx){
        try (SqlSession ss = FactoryService.getFactory().openSession(true)) {
            int cnt =ss.update("member.updateLastLogin", member_idx);
            ss.close();
            return cnt;
        }
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

    public static void updateKakaoMyInfo(MemberVO mvo){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("member.changeKakaoMyInfo", mvo);

        if(cnt >0)
            ss.commit();
        else
            ss.rollback();
        ss.close();
    }

    public static void updateMemInfo(MemberVO mvo){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("member.updateMemInfo", mvo);

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

    // 이름과 이메일로 회원 정보 조회 (아이디 찾기용)
    public static MemberVO findMemberByNameAndEmail(String member_name, String member_email) {
        SqlSession ss = FactoryService.getFactory().openSession();
        try {
            java.util.Map<String, String> params = new java.util.HashMap<>();
            params.put("member_name", member_name);
            params.put("member_email", member_email);
            MemberVO mvo = ss.selectOne("member.findByNameAndEmail", params);
            return mvo;
        } finally {
            ss.close();
        }
    }

    // 아이디, 이름, 이메일로 회원 정보 조회 (비밀번호 찾기용)
    public static MemberVO findMemberByIdNameAndEmail(String member_id, String member_name, String member_email) {
        SqlSession ss = FactoryService.getFactory().openSession();
        try {
            java.util.Map<String, String> params = new java.util.HashMap<>();
            params.put("member_id", member_id);
            params.put("member_name", member_name);
            params.put("member_email", member_email);
            MemberVO mvo = ss.selectOne("member.findByIdNameAndEmail", params);
            return mvo;
        } finally {
            ss.close();
        }
    }

    // 임시 비밀번호 업데이트
    public static int updateTempPassword(String member_idx, String hashedPassword, String newSalt) {
        SqlSession ss = FactoryService.getFactory().openSession();
        try {
            java.util.Map<String, String> params = new java.util.HashMap<>();
            params.put("member_idx", member_idx);
            params.put("hashedPassword", hashedPassword);
            params.put("newSalt", newSalt);
            int cnt = ss.update("member.updateTempPassword", params);
            if (cnt > 0) {
                ss.commit();
            } else {
                ss.rollback();
            }
            return cnt;
        } finally {
            ss.close();
        }
    }


}
