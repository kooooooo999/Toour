package toour.login.action;

import toour.action.Action;
import toour.member.vo.MemberVO;
import toour.login.dao.MemberDAO;
import toour.util.Hash;
import toour.util.Salt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class SignUpAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String viewPath = null;
        int cmd = 0;
        //사용자가 입력한 아이디
        String u_id =request.getParameter("u_id");
        //사용자가 입력한 비밀번호
        String u_pw =request.getParameter("u_pw");
        //사용자가 입력한 확인번호
        String u_repw =request.getParameter("u_repw");
        //사용자가 입력한 이름
        String u_name =request.getParameter("u_name");
        //사용자가 입력한 별명
        String u_nickname =request.getParameter("u_nickname");
        //사용자가 입력한 이메일
        String u_email =request.getParameter("u_email");
        String u_emailAddr = request.getParameter("emailAddr");
        //모든 값이 존재하고 비밀번호오 확인번호가 같을 때
        if(u_id!=null && u_pw!=null&& u_name!=null&& u_nickname!=null&& u_email!=null&&u_repw.equals(u_pw)){
            // 비밀번호와 같이 암호화할 salt 얻어내기
            String salt = Salt.getSalt();

            //비밀번호와 salt 둘을 합쳐 hash함수로 암호화 
            String hash_pw= Hash.getHash(salt+u_pw);

            //데이터 베이스에 저장할 VO생성
            MemberVO mvo = new MemberVO();
            //아이디 컬럼 만들고 나서 저장할 것
            mvo.setMember_id(u_id);
            mvo.setMember_password(hash_pw);
            mvo.setMember_name(u_name);
            mvo.setMember_nickname(u_nickname);
            if(u_emailAddr.length()==0) {
                u_emailAddr = request.getParameter("u_email2");
            }
            mvo.setMember_email(u_email + "@"+ u_emailAddr);
            mvo.setMember_salt(salt);
            mvo.setLogin_type("LOCAL");
            
            //데이터베이스에 회원 정보 저장!
            int cnt = MemberDAO.addMem(mvo);

            cmd =1;
            viewPath = "MainIndex/index.jsp";
        }

        if(cmd==0){
            viewPath ="member/signup.jsp";
        }
        return "MainIndex/index.jsp";
    }
}
